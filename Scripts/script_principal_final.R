#####Script principal pour le jeu de données Séries Temporelles#####

##packages a installer##
install.packages("dplyr")
install.packages("tidyverse")
install.packages("stringr")



###Importation des données###

#Importer les données relatives à la taxonomie#
source("importer_taxo.R")
taxo <- import.taxo()

#Importer et combiner tous les csv d'observations en un seul objet#
source("combiner_donnees_brutes.R")
donnees <- combiner.csv()



###Nettoyage des données pour les observations###

#corriger les colonnes qui se sont dédoublées à cause de fautes d'orthographe/non conformité des noms de colonnes#
source("correction_colonnes.R")
donnees.col.corr <- corriger.col(donnees)

#separer les annees et abondances pour avoir 1 ligne = 1 année, 1 abondance#
source("separer_annee_abondance.R")
ab.annee <- Separer.annee.abondance(donnees.col.corr)

#effacer les observations doublons#
source("supprimer_doublons.R")
ab.annee.simple <- Supprimer.doublons(ab.annee)

#separer les coordonnees gps en colonnes x et y#
source("separer_coordo_gps.R")
ab.annee.x.y<- Separer.coordo.gps(ab.annee.simple)

#Vérifier les abondances négatives
source("verifier_ab_neg.R")
Verifier.abondance.negative(ab.annee.x.y)
#La fonction nous retourne qu'il n'y a aucune valeur négative d'abondance, donc pas besoin de créer une fonction pour gérer les abondances négatives#

#Évaluer la présence de caractères spéciaux problématiques#
source("detecter_special_char.R")
Detecter.special.char(ab.annee.x.y)
# Pour ^ : On observe "^" dans $unit qui correspond à un exposant donc ok.
# Pour @ : On observe "@" dans $title puisque des adresses courriels sont inclus dans cette colonne donc ok.
# Pour - : On observe "-" dans $unit, $values, $title et $coordo_y. Ça représente un exposant négatif dans values et unit, les coordonnées en y sont toutes négatives, et c'est possible de retrouver ce symbole dans un contexte textuel dans le titre. Donc, tout est ok.
# Pour ? : On observe "?" dans $unit et $title.Pour le titre, c'est ok puisqu'un titre d'article scientifique peut être une question. Pour $unit par contre, ça signifie qu'il y a de l'incertitude quant aux unités de mesure de l'abondance

#Creer une colonne notes pour gerer la presence de ? dans $unit sans perdre l'information d'incertitude#
source("creer_col_notes.R")
ajout.notes <- creer.col.notes(ab.annee.x.y)

#Corriger les ? dans la colonne $unit et inscrire l'information d'incertitude dans la colonne notes#
source("corriger_unit.R")
obs.clean <- corriger.unit(ajout.notes)



###Creation dataframes et assignation du bon type de données pour les données d'observations###

#creation dataframe et assignation type de données pour references#
source("Creation_dataframe_ref.R")
table_ref <- creer.ref(obs.clean)



#dataframe observations#
source("Creation_dataframe_obs.R")
table_obs <- creer.obs(obs.clean)



###Creation dataframes pour les données de taxonomie###

#dataframe taxonomie#
source("Creation_dataframe_taxo.R")
data_taxo <- creer.taxo()
