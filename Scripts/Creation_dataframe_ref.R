#Creation dataframe references#
creer.ref <- function(data){
  dataframe2<- data[,c("original_source", "creator", "title", "publisher", "intellectual_rights", "license", "owner")]
  for (i in 1:7){
    dataframe2[,i] <- as.character(dataframe2[,i])
  }
  return(dataframe2)
}