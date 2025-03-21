#Creation dataframe observations et assignation du type de données a chaque colonne#
creer.obs <- function(data){
  dataframe3 <- data[,c("observed_scientific_name", "years", "unit", "values", "coordo_x", "coordo_y", "notes")] #creation d'une matrice de 9 colonnes#
  dataframe3 <- dataframe3 %>%
    mutate(
      observed_scientific_name = as.character(observed_scientific_name),
      unit = as.character(unit),
      notes = as.character(notes),
      years = as.numeric(years),
      values = as.numeric(values),
      coordo_x = as.numeric(coordo_x),
      coordo_y = as.numeric(coordo_y)
    )
  return(dataframe3)
}