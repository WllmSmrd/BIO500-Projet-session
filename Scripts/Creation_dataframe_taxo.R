#Creation dataframe taxonomie#
creer.taxo <- function(){
  dataframe1 <- matrix(,,11) #creation matrice de 11 colonnes#
  colnames(dataframe1) <- c("observed_scientific_name", "valid_scientific_name", "rank", "vernacular_fr", "kingdom", "phylum", "class", "order", "family", "genus", "species") #identification des noms de ces 11 colonnes#
  return(dataframe1)
}