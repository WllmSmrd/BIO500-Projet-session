##################################################
# Fonction qui permet d'injecter les données dans la base de données SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

injection_ref <- function(table){
con <- dbConnect(RSQLite::SQLite(), dbname = "./database_series_temporelles.db")
on.exit(dbDisconnect(con))
dbWriteTable(con, append = FALSE, name = "references", value = table, row.names = FALSE, overwrite = TRUE) #permet d'injecter les données de references#
}