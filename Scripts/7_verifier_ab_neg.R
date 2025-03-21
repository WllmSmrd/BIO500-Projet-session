### Vérifier s'il y a des valeurs d'abondance négatives dans la colonne "values"

Verifier.abondance.negative <- function(negative){
  resultat <- any(negative$values < 0)
  print(resultat)
}