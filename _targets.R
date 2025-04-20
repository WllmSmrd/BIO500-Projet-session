# ===========================================
# _targets.R file
# ===========================================
# Dépendances
library(targets)
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
source("./Scripts/20_injecter.R")
source("./Scripts/21_verifier_injection_sql.R")
source("./Scripts/22_selection_donnees_biodiv.R")
source("./Scripts/23_selection_donnees_taxons.R")
source("./Scripts/24_creer_figure_1.R")
source("./Scripts/25_creer_figures_2_3.R")


# Pipeline
list(
  tar_target(
    name = path, # Cible
    command = "data/data.txt", # Emplacement du fichier
    format = "file"
  ), 
  # La target suivante a "path" pour dépendance et importe les données. Sans
  # la séparation de ces deux étapes, la dépendance serait brisée et une
  # modification des données n'entrainerait pas l'exécution du pipeline
  
  #Importation des données
  #données observations
  
  #données taxonomie
  tar_target(
    name = data, # Cible pour l'objet de données
    command = read.table(path) # Lecture des données
  ),
  
  #Nettoyage et validation
  #données observations
  
  #données taxonomie
  tar_target(
    resultat_modele, # Cible pour le modèle 
    mon_modele(data) # Exécution de l'analyse
  ),
  
  #Préparation des données pour injection pour injection
  
  #Création de la base de données et injection
  tar_target(
    figure, # Cible pour l'exécution de la figure
    ma_figure(data, resultat_modele) # Réalisation de la figure
  )
  
  #Extraction des données pour l'analyse
  
  #Analyse et visualisation
)