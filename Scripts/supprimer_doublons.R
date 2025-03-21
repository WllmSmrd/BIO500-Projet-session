
# Supprimer les doublons 

Supprimer.doublons <- function(doublons){
  csv_clean_unique <- doublons[!duplicated(doublons), ]
  return(csv_clean_unique)
}