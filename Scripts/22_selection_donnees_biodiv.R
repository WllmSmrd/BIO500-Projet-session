##################################################
# Fonction qui permet d'extraire de la base de données SQL 
# les données utiles pour l'analyse 
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 16-04-2025
##################################################


requete.biodiv <-
"SELECT 
    years,
    COUNT(DISTINCT observed_scientific_name) AS nombre_especes
FROM 
    observations
GROUP BY 
    years
ORDER BY 
    years;
"