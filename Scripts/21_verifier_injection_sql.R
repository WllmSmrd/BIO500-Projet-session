##################################################
# Fonction qui permet de vérifier que les données ont bien été injectées 
# dans la base de donnés SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


verifier.injection.sql <- function(database){
  dbListTables(database) #lister les tables pour vérifier qu'elles sont bien dans la base de données (BD)
  dbGetQuery(database, 'SELECT * FROM observations LIMIT 4') #requête pour la table observations
  dbGetQuery(database, 'SELECT * FROM taxonomie LIMIT 4')    #requête pour la table taxonomie
  dbGetQuery(database, 'SELECT * FROM "references" LIMIT 4') #requête pour la table references (entre guillements pour différencier de la bd déjà existante)
}



