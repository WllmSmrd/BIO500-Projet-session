##################################################
# Fonction qui permet d'insérer des NA dans les cases vides                           
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

insert.na <- function(data){
  data <- data %>%
    mutate(across(everything(), ~ na_if(., "")))
  return(data)
}