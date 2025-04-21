##################################################
# Fonction qui permet d'injecter les données dans la base de données SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

injection_obs <- function(table){
con <- dbConnect(RSQLite::SQLite(), dbname = "./database_series_temporelles.db")
on.exit(dbDisconnect(con))
dbWriteTable(con, append = TRUE, name = "observations", value = table, row.names = FALSE) #permet d'injecter les données d'observations#
}