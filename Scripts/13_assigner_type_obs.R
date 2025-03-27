##################################################
# Fonction qui permet d'assigner le bon type de données à chaque 
# colonne du fichier observations                    
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


assigner.type.obs <- function(ancientype){
  nouveautype <- ancientype %>%
    mutate(
      across(c("observed_scientific_name", "unit", "geom", "original_source", "creator", 
               "title", "publisher", "license", "owner", "notes"), as.character),
      # Fait passer les colonnes souhaitées en type caractère
      across(c("years", "values", "coordo_x", "coordo_y"), as.numeric),
      # Fait passer les colonnes souhaitées en type numérique
      across(c("intellectual_rights"), as.logical)
      # Fait passer la colonne souhaitée en type logical
    ) 
  return(nouveautype)
}

