# BIO500-Projet-session


### DESCRIPTION DU PROJET ######################################################

#Objectif 

Dans le cadre du cours BIO500, l'objectif de ce travail de session est de répondre 
à la question suivante : Comment les variations spatiales et temporelles influent-elles 
sur la structure des communautés ?

L'analyse d'un inventaire écologique nous permettra de répondre à cette question.

#Données

Notre inventaire écologique est constitué de séries temporelles issues de mesures 
répétées de taille de population. 

Résolution spatiale et temporelle : 

- 8248 suivis de populations
- Entre 2 et ~40 mesures répétées
- Données : espèces, année, coordonnées spatiales, taille de population

#Méthodes

#Résultats 



### STRUCTURE DU REPERTOIRE ####################################################

Le répertoire contient un fichier de données `Data` et fichiers de scripts `Scripts` :

- `Data`comprend l'ensemble des données de séries temporelles utilisés pour l'analyse
- `Scripts` comprend l'ensemble des scripts créés pour l'analyse

#Description des scripts

Script principal qui regroupe et fait fonctionner toutes les fonctions adjacentes :
- `0_script_principal_final.R` 
   
Les scripts suivant regroupent les fonctions utilisées importer les données :
- `1_importer_taxo.R`
- `2_combiner_donnees_brutes.R`

Les scripts suivant regroupent les fonctions utilisées pour valider et nettoyer les données :
- `3_correction_colonnes.R`
- `4_separer_annee_abondance.R`
- `5_supprimer_doublons.R`
- `6_separer_coordo_gps.R`
- `7_verifier_ab_neg.R`
- `8_detecter_special_char.R`
- `9_creer_col_notes.R`
- `10_corriger_unit.R`

Les scripts suivant regroupent les fonctions utilisées pour créer des dataframes :
- `Creation_dataframe_obs.R`
- `Creation_dataframe_ref.R`
- `Creation_dataframe_taxo.R`



### INSTRUCTIONS ###############################################################


### AUTEURS ####################################################################

William Simard 
Zoé Chol
Kyara Boisvert










