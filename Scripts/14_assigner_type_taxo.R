##################################################
# Fonction qui permet d'assigner le bon type de données à chaque 
# colonne du fichier taxonomie                    
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


assigner.type.taxo <- function(ancientype){
  nouveautype <- ancientype %>%
    mutate(across(everything(), as.character))
  return(nouveautype)
}

