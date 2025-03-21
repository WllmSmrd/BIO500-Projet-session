##################################################
# Fonction qui permet d'importer et combiner tous les csv d'observations en un seul objet                               
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


library("dplyr")

combiner.csv <- function(){
  files <- list.files(path = "./donnees", pattern = "*.csv", full.names = TRUE) #cherche tous les dpcuments .csv dans le working directory et les liste dans un objet#
  csv_combined <- bind_rows(lapply(files, read.csv)) #lis tous les csv contenus dans files et les combine par rangée#
  return(csv_combined)
}

