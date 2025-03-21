##################################################
# Fonction qui permet l'importation du fichier relatif à la taxonomie                                 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


import.taxo <- function(){
  taxo <- read.csv("taxonomie.csv")
  return(taxo)
}