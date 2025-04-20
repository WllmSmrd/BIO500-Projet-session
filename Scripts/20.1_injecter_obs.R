##################################################
# Fonction qui permet d'injecter les données dans la base de données SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

injection_obs <- function(table){
dbWriteTable(connection_abondances_bd, append = TRUE, name = "observations", value = table, row.names = FALSE) #permet d'injecter les données d'observations#
}