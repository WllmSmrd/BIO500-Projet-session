##################################################
# Fonction qui permet de créer  le dataframe des références                    
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


creer.ref <- function(data){
  dataframe2<- data[,c("original_source", "creator", "title", "publisher", 
                       "intellectual_rights", "license", "owner")]
  dataframe2.1 <- unique(dataframe2)
  return(dataframe2.1)
}