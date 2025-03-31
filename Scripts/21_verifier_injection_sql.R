##################################################
# Fonction qui permet de vérifier que les données ont bien été injectées 
# dans la base de donnés SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


verifier.injection.sql <- function(database){
  tables <- dbListTables(database) #lister les tables pour vérifier qu'elles sont bien dans la base de données (BD)
  observations <- dbGetQuery(database, 'SELECT * FROM observations LIMIT 4') #requête pour la table observations
  taxonomie <- dbGetQuery(database, 'SELECT * FROM taxonomie LIMIT 4')       #requête pour la table taxonomie
  references <- dbGetQuery(database, 'SELECT * FROM "references" LIMIT 4')   #requête pour la table references (entre guillements pour différencier de la bd déjà existante)

  return(list(
    tables = tables,
    observations = observations,
    taxonomie = taxonomie,
    references = references
  ))
}

