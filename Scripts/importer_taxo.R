#importation du fichier relatif à la taxonomie#
import.taxo <- function(){
  taxo <- read.csv("taxonomie.csv")
  return(taxo)
}