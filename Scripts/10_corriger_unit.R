##################################################
# Fonction qui permet de corriger les "?" dans la colonne $unit et inscrire 
# l'information d'incertitude dans la colonne notes                        
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


corriger.unit <- function(notesvides) {
  notesvides$notes <- as.character(notesvides$notes)
  # Utilisation de grepl pour identifier les "?" et appliquer la condition sur la colonne "notes"
  notesvides$notes <- ifelse(grepl('\\?', notesvides$unit), 
                             "incertitude des unités de mesure de l'abondance", 
                             NA)
  # Supprimer le "?" dans la colonne "unit" pour les lignes qui en contiennent
  notesvides$unit <- gsub('\\?', '', notesvides$unit)
  return(notesvides)
}
