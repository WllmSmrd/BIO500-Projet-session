##################################################
# Fonction qui permet de corriger les colonnes qui se sont dédoublées à cause de 
# fautes d'orthographe/non conformité des noms de colonnes                             
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


# Deux colonnes supplémentaires sont apparues : "geometry" et "lisense" dues à des 
# erreurs contenues respctivement dans les csv 257 et 94.
# Le code suivant permet de les recombiner correctement.

corriger.col <- function(donnees_combinees){
  col_corrigees <- donnees_combinees %>%
    mutate(
      geom = coalesce(geom, geometry), #remplace les NA de geom par la valeur de geometry
      license = coalesce(license, lisense) #remplace les NA de license par la valeur de lisense 
    ) %>%
    select(-geometry, -lisense)  #supprime les colonnes geometry et lisense 
  return(col_corrigees)
}