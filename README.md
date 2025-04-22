# BIO500-Projet-session

### AUTEURS ####################################################################

William Simard 
Zoé Chol
Kyara Boisvert

### DESCRIPTION DU PROJET ######################################################

#Contexte et objectif 

Dans le cadre du cours BIO500, l'objectif de ce travail de session est de répondre 
à la question suivante : Comment les variations spatiales et temporelles influent-elles 
sur la structure des communautés ?

L'analyse d'un inventaire écologique nous permettra de répondre à cette question.


#Données

Notre inventaire écologique est constitué de séries temporelles issues de mesures 
répétées d'abondance de populations de différentes espèces. Ces données proviennent
de l'organisation Biodiversité Québec.


#Méthodes



#Résultats 



### STRUCTURE DU REPERTOIRE ####################################################

Dossiers:

- `Data`comprend l'ensemble des données de séries temporelles et de taxonomie utilisées pour l'analyse
- `Scripts` comprend l'ensemble des scripts créés pour l'analyse
- `_targets` comprend toutes les targets créées dans le pipeline du projet
- `Article_BIO500` comprend tous les fichiers associés à la création du rapport

Fichiers:

- `README.md` le présent document expliquant l'organisation du répertoire
- `figure_1_esp_par_annee.pdf` figure 1 du rapport
- `figure_2_obs_par_classe.pdf` figure 2 du rapport
- `figure_3_declin_classe.pdf` figure 1 du rapport
- `database_series_temporelles.db` serveur de la base de données SQL du projet
- `Execution_targets.R` comprend les quelques lignes de code permettant d'exécuter le pipeline target

#Description des données (dossier Data)
## Fichiers de données

- `*.csv` séries temporelles d'un ensemble de populations mesuré dans un même jeu de données. Chaque ligne correspond à une population distincte.
- `taxonomie.csv` correspondance entre les noms scientifiques observés et la taxonomie validée, les noms communs et la taxonomie complète des espèces. Le lien entre les données de population et la taxonomie se fait à l'aide de la colonne `observed_scientific_name`.

### Séries temporelles de populations (*.csv)

Ce jeu de données contient des inventaires de populations répétés dans le temps qui témoignent de l'évolution de la biodiversité dans le temps (<https://www.livingplanetindex.org/>). 
Ces séries temporelles de taille de populations ont été collectées par Biodiversité Québec depuis plusieurs sources et ont déjà été standardisées pour faciliter leur utilisation. 
La standardisation comprend la conversion des abondances en unités de densité pour un effort constant (ex. nombre d'individus par mètre carré).

#### Description des variables

- `observed_scientific_name` Nom scientifique de l'espèce observée
- `years` Années de mesurage
- `unit` Unité de mesure
- `values` Abondance de la population observée
- `geom` Coordonnées géographiques de l'observation
- `original_source` Source originale des données
- `creator` Auteur des données
- `title` Titre du jeu de données dont les données sont extraites
- `publisher` Éditeur des données
- `intellectual_rights` Droits intellectuels
- `license` Licence des données
- `owner` Propriétaire des données

### Taxonomie (taxonomie.csv)
#### Description des variables

- `observed_scientific_name` Nom scientifique de l'espèce observée
- `valid_scientific_name` Nom scientifique de l'espèce observée tel qu'enregistré à l'IRIS
- `rank` rang taxonomique de l'espèce observée (genre, espèce, sous-espèce, etc.)
- `vernacular_fr` Nom vernaculaire de l'espèce en français
- `kingdom` règne de l'espèce
- `phylum` embranchement de l'espèce
- `class` classe de l'espèce
- `order` ordre de l'espèce
- `family` famille de l'espèce
- `genus` genre de l'espèce
- `species` espèce


#Description des scripts (dossier Scripts)

Script principal qui regroupe et fait appel à tous les scripts nécessaires pour l'analyse :
- `0_script_principal_final.R` 
   
Les scripts suivant regroupent les fonctions utilisées pour importer les données :
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
- `11_detecter_special_char_taxo.R` 
- `12_inserer_NA.R`
- `13_assigner_type_obs.R`
- `14_assigner_type_taxo.R`

Les scripts suivant regroupent les fonctions utilisées pour créer des dataframes prêts à être injectés dans la base de données SQL à des fins d'archivage:
- `14_assigner_type_taxo.R`
- `15_creation_dataframe_ref.R`
- `16_creation_dataframe_obs.R`

Les scripts suivant regroupent les fonctions utilisées pour créer les tables dans la base de données SQL à des fins d'archivage:
- `17_table_taxo_sql.R`
          *Cette table regroupe toutes les informations relatives à la taxonomie des espèces observées
          - `observed_scientific_name` Nom scientifique de l'espèce observée (qui sert de clé primaire)
          - `valid_scientific_name` Nom scientifique de l'espèce observée tel qu'enregistré à l'IRIS
          - `rank` rang taxonomique de l'espèce observée (genre, espèce, sous-espèce, etc.)
          - `vernacular_fr` Nom vernaculaire de l'espèce en français
          - `kingdom` règne de l'espèce
          - `phylum` embranchement de l'espèce
          - `class` classe de l'espèce
          - `order` ordre de l'espèce
          - `family` famille de l'espèce
          - `genus` genre de l'espèce
          - `species` espèce
          
- `17_table_ref_sql.R`
          *Cette table regroupe les informations relatives aux sources desquelles proviennent les données des séries temporelles
              - `original_source` Source originale des données
              - `creator` Auteur des données
              - `title` Titre du jeu de données dont les données sont extraites (qui sert de clé primaire)
              - `publisher` Éditeur des données
              - `intellectual_rights` Droits intellectuels
              - `license` Licence des données
              - `owner` Propriétaire des données
              
- `17_table_obs_sql.R`
          *Cette table regroupe les informations relatives aux observations des populations des séries temporelles
              - `observed_scientific_name` Nom scientifique de l'espèce observée (qui sert de clé secondaires pour relier les tables observations et taxonomie)
              - `years` Années de prise de données
              - `unit` Unité de mesure de l'abondance
              - `values` Abondance de la population observée
              - `coordo_x` Coordonnée géographique en x de l'observation
              - `coordo_y` Coordonnée géographique en y de l'observation
              - `notes` Commentaires liés à l'observation
              - `title` Titre du jeu de données dont les données sont extraites (qui sert de clé secondaire pour relier les tables observations et references)

Les scripts suivant regroupent les fonctions utilisées pour injecter les données dans les tables SQL à des fins d'archivage:
- `20.1_injecter_obs.R` 
- `20.2_injecter_ref.R`
- `20.3_injecter_taxo.R`
- `21_verifier_injection.R`

Les scripts suivant regroupent les fonctions utilisées pour extraire des tables SQL les données utilisées pour l'analyse:
- `22_selection_donnees_biodiv.R`
- `23_selection_donnees_taxons.R`

Les scripts suivant regroupent les fonctions utilisées pour produire les figures illustrant l'analyse:
- `24_creer_figure_1.R`
- `25_creer_figure_2.R`
- `26_creer_figure_3.R`   


### INSTRUCTIONS ##################################################

Pour exécuter le projet
  - ouvrir le fichier Execution_targets.R
  - éxécuter le code du script






