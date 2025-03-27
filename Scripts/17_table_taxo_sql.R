##################################################
# Fonction qui permet de créer une table taxonomie dans la bae de données SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

Creer.table.taxo <- function(){
  "CREATE TABLE taxonomie (
      observed_scientific_name  VARCHAR(100),
      valid_scientific_name     VARCHAR(100),
      rank                      VARCHAR(10),
      vernacular_fr             VARCHAR(100),
      kingdom                   VARCHAR(10),
      phylum                    VARCHAR(10),
      class                     VARCHAR(20),
      'order'                   VARCHAR(50),
      family                    VARCHAR(50),
      genus                     VARCHAR(50),
      species                   VARCHAR(100),
      PRIMARY KEY (observed_scientific_name)
  )"
dbSendQuery(abondances_bd,Creer_taxo)
}

