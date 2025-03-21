
### Détecter des potentiels caractères problématiques pour chaque colonne 

Detecter.special.char <- function(caracteres_speciaux){
  columns_to_check <- c("observed_scientific_name", "years", "unit", "values", "original_source", 
                        "creator", "title", "publisher" , "intellectual_rights", "license", "owner", 
                        "coordo_x", "coordo_y") #définie les colonnes à vérifier
  
  special_char <- c("\\?", "\\^", "\\@", "\\-") #définie les caractères spéciaux à verifier 
  
  results <- lapply(special_char, function(char) {
    sapply(columns_to_check, function(col) table(grepl(char, caracteres_speciaux[[col]]))) #verifie la presence des caracteres speciaux identifies dans chaque colonne identifiee#
  })
  names(results) <- special_char  #afficher les noms des caractères spéciaux quand R nous montre les resultats
  print(results)
}

