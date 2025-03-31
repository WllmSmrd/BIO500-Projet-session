##################################################
# Fonction qui permet d'injecter les données dans la base de données SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

injection <- function(database){
  dbWriteTable(database, append = TRUE, name = "taxonomie", value = table_taxo, row.names = FALSE) #permet d'injecter les données de taxonimie#
  dbWriteTable(database, append = TRUE, name = "references", value = table_ref, row.names = FALSE) #permet d'injecter les données de references#
  dbWriteTable(database, append = TRUE, name = "observations", value = table_obs, row.names = FALSE) #permet d'injecter les données d'observations#
}