# Deux colonnes supplémentaires sont apparues : "geometry" et "lisense" dues à des 
# erreurs contenues respctivement dans les csv 257 et 94.
# Le code suivant permet de les recombiner correctement 

corriger.col <- function(donnees_combinees){
  col_corrigees <- donnees_combinees %>%
    mutate(
      geom = coalesce(geom, geometry), #remplace les NA de geom par la valeur de geometry
      license = coalesce(license, lisense) #remplace les NA de license par la valeur de lisense 
    ) %>%
    select(-geometry, -lisense)  #supprime les colonnes geometry et lisense 
  return(col_corrigees)
}