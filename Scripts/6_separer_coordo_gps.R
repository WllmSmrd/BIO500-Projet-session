##################################################
# Fonction qui permet de séparer les coordonnees gps en colonnes x et y                         
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


# Le code suivant permet de séparer les coordonnées GPS en une colonne x et une colonne y.

library(stringr)

Separer.coordo.gps <- function(doublons_supp){
  coordo_x_y <- doublons_supp %>%
    mutate(
      coordo_x = str_extract(geom, "-?\\d+\\.?\\d*(?=\\))"),
      coordo_y = str_extract(geom, "(?<=\\(-?)[-0-9\\.]+")           
    )
  return(coordo_x_y)
}