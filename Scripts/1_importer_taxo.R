##################################################
# Fonction qui permet l'importation du fichier relatif à la taxonomie                                 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


import.taxo <- function(chemin){
  taxo <- read.csv(chemin)
  return(taxo)
}