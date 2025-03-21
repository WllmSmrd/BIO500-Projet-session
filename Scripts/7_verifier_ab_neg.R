##################################################
# Fonction qui permet de vérifier les abondances négatives                         
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


# Le code suivant permet de vérifier s'il y a des valeurs d'abondance négatives dans la colonne "values".

Verifier.abondance.negative <- function(negative){
  resultat <- any(negative$values < 0)
  print(resultat)
}