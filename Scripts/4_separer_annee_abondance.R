# Fonction pour créer un tableau où chaque ligne correspond a une abondance d'une espece pour une annee a un endroit precis#

library(tidyverse)

Separer.annee.abondance <- function(colcorr){
  csv_clean <- colcorr %>%
    mutate(
      years = str_remove_all(years, "\\[|\\]") %>% str_split(","), 
      values = str_remove_all(values, "\\[|\\]") %>% str_split(",") #supprime les crochets et sépare les valeurs en une liste
    ) %>%
    unnest(cols = c(years, values)) %>% #transforme les listes en lignes distinctes
    mutate(
      years = as.integer(years),
      values = as.numeric(values) #convertit en format numérique
    )
  return(csv_clean)
}

