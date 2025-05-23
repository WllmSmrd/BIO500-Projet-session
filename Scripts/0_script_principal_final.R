##################################################
# Script principal                                  
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


### ACTIVER LIBRAIRIES #########################################################
library(dplyr)
library(tidyverse)
library(stringr)
library(RSQLite)



### IMPORTATION DES DONNEES ####################################################

# 1/ Importer les données relatives à la taxonomie
source("./Scripts/1_importer_taxo.R")
taxo <- import.taxo("./Data/taxonomie.csv")

# 2/ Importer et combiner tous les csv d'observations en un seul objet
source("./Scripts/2_combiner_donnees_brutes.R")
donnees <- combiner.csv("./Data/series_temporelles")



### VALIDATION ET NETTOYAGE DES DONNEES ########################################

# 3/ Corriger les colonnes qui se sont dédoublées à cause de fautes d'orthographe/non conformité des noms de colonnes
source("./Scripts/3_correction_colonnes.R")
donnees_col_corr <- corriger.col(donnees)

# 4/ Séparer les annees et abondances pour avoir 1 ligne = 1 année, 1 abondance
source("./Scripts/4_separer_annee_abondance.R")
ab_annee <- Separer.annee.abondance(donnees_col_corr)

# 5/ Effacer les observations doublons
source("./Scripts/5_supprimer_doublons.R")
ab_annee_simple <- Supprimer.doublons(ab_annee)

# 6/ Séparer les coordonnees gps en colonnes x et y
source("./Scripts/6_separer_coordo_gps.R")
ab_annee_x_y<- Separer.coordo.gps(ab_annee_simple)

# 7/ Vérifier les abondances négatives
source("./Scripts/7_verifier_ab_neg.R")
Verifier.abondance.negative(ab_annee_x_y) #La fonction nous retourne qu'il n'y a 
                                          #aucune valeur négative d'abondance, 
                                          #donc pas besoin de créer une fonction pour 
                                          #gérer les abondances négatives

# 8/ Évaluer la présence de caractères spéciaux problématiques pour les observations
source("./Scripts/8_detecter_special_char_obs.R")
Detecter.special.char.obs(ab_annee_x_y)
# Pour ^ : On observe "^" dans $unit qui correspond à un exposant donc ok.
# Pour @ : On observe "@" dans $title puisque des adresses courriels sont inclus dans cette colonne donc ok.
# Pour - : On observe "-" dans $unit, $values, $title et $coordo_y. Ça représente un exposant négatif dans values et unit, les coordonnées en y sont toutes négatives, et c'est possible de retrouver ce symbole dans un contexte textuel dans le titre. Donc, tout est ok.
# Pour ? : On observe "?" dans $unit et $title.Pour le titre, c'est ok puisqu'un titre d'article scientifique peut être une question. Pour $unit par contre, ça signifie qu'il y a de l'incertitude quant aux unités de mesure de l'abondance

# 9/ Creer une colonne notes pour gerer la presence de "?" dans $unit sans perdre l'information d'incertitude
source("./Scripts/9_creer_col_notes.R")
ajout_notes <- creer.col.notes(ab_annee_x_y)

# 10/ Corriger les "?" dans la colonne $unit et inscrire l'information d'incertitude dans la colonne notes
source("./Scripts/10_corriger_unit.R")
obs_corrigee_unit <- corriger.unit(ajout_notes)

# 11/ Évaluer la présence de caractères spéciaux problématiques pour les observations
source("./Scripts/11_detecter_special_char_taxo.R")
Detecter.special.char.taxo(taxo)
#Pour - : on observe "-" dans $vernacular_fr et c'est normal puisque le nom français des espèces peut contenir ce symbole. Donc c'est ok

# 12/ Insérer des NA dans les cases vides de l'objet taxo 
source("./Scripts/12_inserer_NA.R")
taxo_NA <- insert.na(taxo)

# 13/ Assigner le bon type de données à chaque colonne de l'objet observations       
source("./Scripts/13_assigner_type_obs.R")
obs_clean <- assigner.type.obs(obs_corrigee_unit)

# 14/ Assigner le bon type de données à chaque colonne du dataframe taxonomie (maintenant prêt à injection)     
source("./Scripts/14_assigner_type_taxo.R")
table_taxo <- assigner.type.taxo(taxo_NA)



### CREATION DATAFRAME #########################################################

# 15/ Création dataframe pour references (maintenant prêt à injection)
source("./Scripts/15_creation_dataframe_ref.R")
table_ref <- creer.ref(obs_clean)

# 16/ Création dataframe observations (maintenant prêt à injection)
source("./Scripts/16_creation_dataframe_obs.R")
table_obs <- creer.obs(obs_clean)



### CREATION BASE DE DONNEES SQL ###############################################
library("RSQLite")
con <- dbConnect(RSQLite::SQLite(), dbname=("./database_series_temporelles.db"))

# 17/ Création de la table de taxonomie dans la base de données SQL
source("./Scripts/17_table_taxo_sql.R")
dbSendQuery(con,Creer.table.taxo)

# 18/ Création de la table references dans la base de données SQL
source("./Scripts/18_table_ref_sql.R")
dbSendQuery(con,Creer.table.ref)

# 19/ Création de la table d'observations dans la base de données SQL
source("./Scripts/19_table_obs_sql.R")
dbSendQuery(con,Creer.table.obs)

# 20/ Injecter données dans base de données SQL
source("./Scripts/20.1_injecter_obs.R")
source("./Scripts/20.2_injecter_ref.R")
source("./Scripts/20.3_injecter_taxo.R")
injection_obs(table_obs)
injection_ref(table_ref)
injection_taxo(table_taxo)

# 21/ Lister les tables pour vérifier qu'elles sont bien dans la BD
source("./Scripts/21_verifier_injection_sql.R")
verifier.injection.sql(con)



### REQUETES POUR EXTRACTION DE DONNEES ########################################

# 22/ Sélectionner les données qui seront utilisées pour l'analyse de la question 1 (biodiversité à travers les années)
source("./Scripts/22_selection_donnees_biodiv.R")
biodiv_years <- dbGetQuery(con, selection_biodiv)

# 23/ Sélectionner les données qui seront utilisées pour l'analyse des questions 2 et 3 (taxons à travers les années)
source("./Scripts/23_selection_donnees_taxons.R")
obs_years_taxon <- dbGetQuery(con, selection_taxons)



### ANALYSES ET VISUALISATION ##################################################

# 24/ Figure pour l'analyse de la question 1 (biodiversité à travers les années)
source("./Scripts/24_creer_figure_1.R")
creer.figure.1(biodiv_years)

# 25/ Figure pour l'analyse de la question 2(taxons à travers les années)
source("./Scripts/25_creer_figure_2.R")
creer.figure.2(obs_years_taxon)

# 26/ Figure pour l'analyse de la question 3
source("./Scripts/26_creer_figure_3.R")
creer.figure.3(obs_years_taxon)

# Se déconnecter de la base de données
dbDisconnect(con)
