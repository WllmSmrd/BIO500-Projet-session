##################################################
# Fonction qui permet de créer  le dataframe des observations                  
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


creer.obs <- function(data){
  dataframe3 <- data[,c("observed_scientific_name", "years", "unit", "values", 
                        "coordo_x", "coordo_y", "notes", "title")]
  return(dataframe3)
}