# ===========================================
# _targets.R file
# ===========================================

# Dépendances
library(targets)
library(tarchetypes)
library(dplyr)
library(tidyverse)
library(stringr)
library(RSQLite)

tar_option_set(packages = c("dplyr", "tidyverse", "stringr", "RSQLite"))

# Scripts R
source("./Scripts/1_importer_taxo.R")
source("./Scripts/2_combiner_donnees_brutes.R")
source("./Scripts/3_correction_colonnes.R")
source("./Scripts/4_separer_annee_abondance.R")
source("./Scripts/5_supprimer_doublons.R")
source("./Scripts/6_separer_coordo_gps.R")
source("./Scripts/7_verifier_ab_neg.R")
source("./Scripts/8_detecter_special_char_obs.R")
source("./Scripts/9_creer_col_notes.R")
source("./Scripts/10_corriger_unit.R")
source("./Scripts/11_detecter_special_char_taxo.R")
source("./Scripts/12_inserer_NA.R")
source("./Scripts/13_assigner_type_obs.R")
source("./Scripts/14_assigner_type_taxo.R")
source("./Scripts/15_creation_dataframe_ref.R")
source("./Scripts/16_creation_dataframe_obs.R")
source("./Scripts/17_table_taxo_sql.R")
source("./Scripts/18_table_ref_sql.R")
source("./Scripts/19_table_obs_sql.R")
source("./Scripts/20.1_injecter_obs.R")
source("./Scripts/20.2_injecter_ref.R")
source("./Scripts/20.3_injecter_taxo.R")
source("./Scripts/21_verifier_injection_sql.R")
source("./Scripts/22_selection_donnees_biodiv.R")
source("./Scripts/23_selection_donnees_taxons.R")
source("./Scripts/24_creer_figure_1.R")
source("./Scripts/25_creer_figures_2_3.R")


# Pipeline
list(

### ÉTABLIR LE CHEMIN D'ACCES VERS LES DONNEES ###########################
  
  tar_target(
    name = path_obs, # Cible
    command = "./Data/series_temporelles", # Emplacement des fichiers
    format = "file"
  ), 
  
  tar_target(
    name = path_taxo, # Cible
    command = "./Data/taxonomie.csv", # Emplacement du fichier
    format = "file"
  ),
  
  
  
### IMPORTATION DES DONNEES ####################################################

  #1/ Importer les données relatives à la taxonomie
  tar_target(taxo, 
    import.taxo(path_taxo)
  ),

  #2/ Importer et combiner tous les csv d'observations en un seul objet
  tar_target(donnees, 
    combiner.csv(path_obs)
  ),
  


### VALIDATION ET NETTOYAGE DES DONNEES ########################################

#ETAPE 1: Données d'observations 
  tar_target(obs.clean, {
  
    # 3/ Corriger les colonnes qui se sont dédoublées à cause de fautes d'orthographe/non conformité des noms de colonnes
    donnees.col.corr = corriger.col(donnees) 
  
    # 4/ Séparer les annees et abondances pour avoir 1 ligne = 1 année, 1 abondance
    ab.annee = Separer.annee.abondance(donnees.col.corr)
  
    # 5/ Effacer les observations doublons
    ab.annee.simple = Supprimer.doublons(ab.annee) 
  
    # 6/ Séparer les coordonnees gps en colonnes x et y
    ab.annee.x.y = Separer.coordo.gps(ab.annee.simple)
  
    # 7/ Vérifier les abondances négatives
    Verifier.abondance.negative(ab.annee.x.y) #La fonction nous retourne qu'il n'y a 
                                              #aucune valeur négative d'abondance, 
                                              #donc pas besoin de créer une fonction pour 
                                              #gérer les abondances négatives
 
    # 8/ Évaluer la présence de caractères spéciaux problématiques pour les observations
    Detecter.special.char.obs(ab.annee.x.y) 
    # Pour ^ : On observe "^" dans $unit qui correspond à un exposant donc ok.
    # Pour @ : On observe "@" dans $title puisque des adresses courriels sont inclus dans cette colonne donc ok.
    # Pour - : On observe "-" dans $unit, $values, $title et $coordo_y. Ça représente un exposant négatif dans values et unit, les coordonnées en y sont toutes négatives, et c'est possible de retrouver ce symbole dans un contexte textuel dans le titre. Donc, tout est ok.
    # Pour ? : On observe "?" dans $unit et $title.Pour le titre, c'est ok puisqu'un titre d'article scientifique peut être une question. Pour $unit par contre, ça signifie qu'il y a de l'incertitude quant aux unités de mesure de l'abondance
 
    # 9/ Creer une colonne notes pour gerer la presence de "?" dans $unit sans perdre l'information d'incertitude
    ajout.notes = creer.col.notes(ab.annee.x.y)

    # 10/ Corriger les "?" dans la colonne $unit et inscrire l'information d'incertitude dans la colonne notes
    obs.corrigee.unit = corriger.unit(ajout.notes)
  
    # 13/ Assigner le bon type de données à chaque colonne de l'objet observations
    obs.clean = assigner.type.obs(obs.corrigee.unit)
  
  }),


#ETAPE 2: Données de taxonomie 
  tar_target(table_taxo, {
  
    # 11/ Évaluer la présence de caractères spéciaux problématiques pour les observations
    Detecter.special.char.taxo(taxo)
    #Pour - : on observe "-" dans $vernacular_fr et c'est normal puisque le nom français des espèces peut contenir ce symbole. Donc c'est ok

    # 12/ Insérer des NA dans les cases vides de l'objet taxo 
    taxo.NA = insert.na(taxo)

    # 14/ Assigner le bon type de données à chaque colonne du dataframe taxonomie (maintenant prêt à injection)     
    table_taxo = assigner.type.taxo(taxo.NA)

  }),



### CREATION DATAFRAME #########################################################

  # 15/ Création dataframe pour references (maintenant prêt à injection)
  tar_target(table_ref, 
    creer.ref(obs.clean)
  ),

  # 16/ Création dataframe observations (maintenant prêt à injection)
  tar_target(table_obs, 
    creer.obs(obs.clean)
  ),



### CREATION BASE DE DONNEES SQL ###############################################

#ETAPE 1: Création des tables dans la base de données SQL
  tar_target(creer_tables_sql, {

    con = dbConnect(RSQLite::SQLite(), dbname = "./database_series_temporelles.db")
    on.exit(dbDisconnect(con))
    
    # 17/ Création de la table de taxonomie dans la base de données SQL
    dbSendQuery(con,Creer.table.taxo)
    
    # 18/ Création de la table references dans la base de données SQL
    dbSendQuery(con,Creer.table.ref)
    
    # 19/ Création de la table d'observations dans la base de données SQL
    dbSendQuery(con,Creer.table.obs)
    
  }),


    
#ETAPE 3: Injection des données dans la base de données SQL et vérification 
  tar_target(injection_sql, {
    
    con = dbConnect(RSQLite::SQLite(), dbname = "./database_series_temporelles.db")
    on.exit(dbDisconnect(con))
    
    # 20/ Injecter données dans base de données SQL
    injection_obs(table_obs)
    injection_ref(table_ref)
    injection_taxo(table_taxo)
    
    # 21/ Lister les tables pour vérifier qu'elles sont bien dans la BD
    verifier.injection.sql(con)
  
  }),



### REQUETES POUR EXTRACTION DE DONNEES ########################################

  # 22/ Sélectionner les données qui seront utilisées pour l'analyse de la question 1 (biodiversité à travers les années)
  tar_target(biodiv_years, {
    con = dbConnect(RSQLite::SQLite(), dbname = "./database_series_temporelles.db")
    on.exit(dbDisconnect(con))
    biodiv_years = dbGetQuery(con, requete.biodiv)
  }),

  # 23/ Sélectionner les données qui seront utilisées pour l'analyse des questions 2 et 3 (taxons à travers les années)
  tar_target(obs_years_taxon, {
    con = dbConnect(RSQLite::SQLite(), dbname = "./database_series_temporelles.db")
    on.exit(dbDisconnect(con))
    obs_years_taxon = dbGetQuery(con, requete.taxons)
  }),



### ANALYSES ET VISUALISATION ##################################################

  # 24/ Figure pour l'analyse de la question 1 (biodiversité à travers les années)
  tar_target(figure_1, 
    creer.figure.1(biodiv_years)
  ),

  # 25/ Figures pour l'analyse des questions 2 et 3 (taxons à travers les années)
  tar_target(figures_2_3, 
    creer.figures.2.3(obs_years_taxon)
  )

)
