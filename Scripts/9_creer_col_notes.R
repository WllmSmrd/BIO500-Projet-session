##################################################
# Fonction qui permet de créer une colonne notes                        
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


# Le code suivant permet de créer une colonne notes pour gérer la presence de "?" 
# dans $unit sans perdre l'information d'incertitude.

creer.col.notes <- function(sansnotes){
  notes <- matrix(,nrow(sansnotes),1)
  colnames(notes) <- c("notes")
  avecnotes <- bind_cols(sansnotes,notes)
  return(avecnotes)
}