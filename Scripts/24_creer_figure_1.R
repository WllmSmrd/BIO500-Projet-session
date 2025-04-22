##################################################
# Fonction qui permet de créer la figure 1 pour l'analyse
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 16-04-2025
##################################################

creer.figure.1 <- function(data){


  
pdf("figure_1_esp_par_annee.pdf", width = 14, height = 6) #pour exportation de la figure en pdf
par(mfrow = c(1,1), mar = c(7, 6, 4, 2), mgp = c(4, 1, 0))   

plot(data$years,
      data$nombre_especes,
      type = "l",                   # pour lignes
      lwd = 2,                      # pour épaissir la ligne
      col = "darkgreen",            # couleur de la ligne
      xlab = "Année",
      ylab = "Nombre d'espèces observées",
      main = "Richesse spécifique par année")

dev.off()

}