# Séparer les coordonnées GPS en une colonne x et une colonne y

library(stringr)

Separer.coordo.gps <- function(doublons_supp){
  coordo_x_y <- doublons_supp %>%
    mutate(
      coordo_x = str_extract(geom, "-?\\d+\\.?\\d*(?=\\))"),
      coordo_y = str_extract(geom, "(?<=\\(-?)[-0-9\\.]+")           
    )
  return(coordo_x_y)
}