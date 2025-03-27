##################################################
# Fonction qui permet d'évaluer la présence de caractères spéciaux problématiques
# dans l'objet taxo
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-03-2025
##################################################


# Le code suivant permet de détecter des potentiels caractères problématiques pour chaque colonne.

Detecter.special.char.taxo <- function(caracteres_speciaux){
  columns_to_check <- c("observed_scientific_name", "valid_scientific_name", "rank", "vernacular_fr", "kingdom", 
                        "phylum", "class", "order" , "family", "genus", "species") 
                        #définie les colonnes à vérifier
  
  special_char <- c("\\?", "\\^", "\\@", "\\-") #définie les caractères spéciaux à verifier 
  
  results <- lapply(special_char, function(char) {
    sapply(columns_to_check, function(col) table(grepl(char, caracteres_speciaux[[col]]))) #verifie la presence des caracteres speciaux identifies dans chaque colonne identifiee#
  })
  names(results) <- special_char  #afficher les noms des caractères spéciaux quand R nous montre les resultats
  print(results)
}