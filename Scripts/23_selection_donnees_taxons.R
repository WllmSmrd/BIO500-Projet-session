##################################################
# Fonction qui permet d'extraire de la base de données SQL 
# les données utiles pour l'analyse 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 16-04-2025
##################################################

selection_taxons <- 
  "SELECT 
      class, 
      years, 
      count(observations.observed_scientific_name) AS Nb_obs
   FROM 
      observations
   JOIN 
      taxonomie ON observations.observed_scientific_name = taxonomie.observed_scientific_name
   WHERE 
      class IS NOT NULL
   GROUP BY 
      class, 
      years;
"