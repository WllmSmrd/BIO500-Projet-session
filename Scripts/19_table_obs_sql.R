##################################################
# Fonction qui permet de créer une table d'observations dans la base de données SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

Creer.table.obs <- function(){
  "CREATE TABLE observations (
      id_obs                  INTEGER PRIMARY KEY AUTOINCREMENT,
      species                 VARCHAR(100),
      years                   INTEGER,
      unit                    VARCHAR(100),
      'values'                REAL,
      coordo_x                REAL,
      coordo_y                REAL,
      source                  VARCHAR(100),
      FOREIGN KEY (species) REFERENCES taxonomie(observed_scientific_name),
      FOREIGN KEY (source) REFERENCES 'references'(id)
  )"
dbSendQuery(abondances_bd,Creer_obs)
}



