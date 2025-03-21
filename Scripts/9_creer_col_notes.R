#creer colonne notes#
creer.col.notes <- function(sansnotes){
  notes <- matrix(,nrow(sansnotes),1)
  colnames(notes) <- c("notes")
  avecnotes <- bind_cols(sansnotes,notes)
  return(avecnotes)
}