##################################################
# Fonction qui permet de créer une table references dans la base de données SQL 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################

Creer.table.ref <-
  "CREATE TABLE 'references' (
      original_source       VARCHAR(100),
      creator               VARCHAR(100),
      title                 VARCHAR(1000),
      publisher             VARCHAR(30),
      intellectual_rights   BOLEAN,
      license               VARCHAR(100),
      owner                 VARCHAR(30),
      PRIMARY KEY (title)
  );"





