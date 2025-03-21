##################################################
# Fonction qui permet de supprimer les doublons                            
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


Supprimer.doublons <- function(doublons){
  csv_clean_unique <- doublons[!duplicated(doublons), ]
  return(csv_clean_unique)
}