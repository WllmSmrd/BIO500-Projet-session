##################################################
# Fonction qui permet de créer une table d'observations dans la base de données SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

Creer.table.obs <-
  "CREATE TABLE observations (
      observed_scientific_name  VARCHAR(100),
      years                     INTEGER,
      unit                      VARCHAR(100),
      'values'                  REAL,
      coordo_x                  REAL,
      coordo_y                  REAL,
      notes                     VARCHAR(100),
      title                     VARCHAR(1000),
      FOREIGN KEY (observed_scientific_name) REFERENCES taxonomie(observed_scientific_name),
      FOREIGN KEY (title) REFERENCES 'references'(title)
  );"




