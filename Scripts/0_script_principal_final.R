##################################################
# Script principal                                  
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


### INSTALLER PACKAGES #########################################################
install.packages("dplyr")
install.packages("tidyverse")
install.packages("stringr")



### IMPORTATION DES DONNEES ####################################################

# 1/ Importer les données relatives à la taxonomie
source("./Scripts/importer_taxo.R")
taxo <- import.taxo()

# 2/ Importer et combiner tous les csv d'observations en un seul objet
source("./Scripts/combiner_donnees_brutes.R")
donnees <- combiner.csv()



### VALIDATION ET NETTOYAGE DES DONNEES ########################################

# 3/ Corriger les colonnes qui se sont dédoublées à cause de fautes d'orthographe/non conformité des noms de colonnes
source("./Scripts/correction_colonnes.R")
donnees.col.corr <- corriger.col(donnees)

# 4/ Séparer les annees et abondances pour avoir 1 ligne = 1 année, 1 abondance
source("./Scripts/separer_annee_abondance.R")
ab.annee <- Separer.annee.abondance(donnees.col.corr)

# 5/ Effacer les observations doublons
source("./Scripts/supprimer_doublons.R")
ab.annee.simple <- Supprimer.doublons(ab.annee)

# 6/ Séparer les coordonnees gps en colonnes x et y
source("./Scripts/separer_coordo_gps.R")
ab.annee.x.y<- Separer.coordo.gps(ab.annee.simple)

# 7/ Vérifier les abondances négatives
source("./Scripts/verifier_ab_neg.R")
Verifier.abondance.negative(ab.annee.x.y) #La fonction nous retourne qu'il n'y a 
                                          #aucune valeur négative d'abondance, 
                                          #donc pas besoin de créer une fonction pour 
                                          #gérer les abondances négatives

# 8/ Évaluer la présence de caractères spéciaux problématiques
source("./Scripts/detecter_special_char.R")
Detecter.special.char(ab.annee.x.y)
# Pour ^ : On observe "^" dans $unit qui correspond à un exposant donc ok.
# Pour @ : On observe "@" dans $title puisque des adresses courriels sont inclus dans cette colonne donc ok.
# Pour - : On observe "-" dans $unit, $values, $title et $coordo_y. Ça représente un exposant négatif dans values et unit, les coordonnées en y sont toutes négatives, et c'est possible de retrouver ce symbole dans un contexte textuel dans le titre. Donc, tout est ok.
# Pour ? : On observe "?" dans $unit et $title.Pour le titre, c'est ok puisqu'un titre d'article scientifique peut être une question. Pour $unit par contre, ça signifie qu'il y a de l'incertitude quant aux unités de mesure de l'abondance

# 9/ Creer une colonne notes pour gerer la presence de "?" dans $unit sans perdre l'information d'incertitude
source("./Scripts/creer_col_notes.R")
ajout.notes <- creer.col.notes(ab.annee.x.y)

# 10/ Corriger les "?" dans la colonne $unit et inscrire l'information d'incertitude dans la colonne notes
source("./Scripts/corriger_unit.R")
obs.clean <- corriger.unit(ajout.notes)



### CREATION DATAFRAME + ASSIGNATION DU BON TYPE DE DONNEES ####################
# -> Pour données d'observations 

# Création dataframe et assignation type de données pour references
source("./Scripts/Creation_dataframe_ref.R")
table_ref <- creer.ref(obs.clean)

# Création dataframe observations
source("./Scripts/Creation_dataframe_obs.R")
table_obs <- creer.obs(obs.clean)



### CREATION DATAFRAME #########################################################
# -> pour données de taxonomie

#dataframe taxonomie#
source("./Scripts/Creation_dataframe_taxo.R")
data_taxo <- creer.taxo()
