##################################################
# Fonction qui permet d'injecter les données dans la base de données SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

injection_ref <- function(table){
dbWriteTable(con, append = TRUE, name = "references", value = table, row.names = FALSE) #permet d'injecter les données de references#
}