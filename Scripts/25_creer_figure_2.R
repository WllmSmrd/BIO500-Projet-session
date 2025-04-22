##################################################
# Fonction qui permet de créer la figure 2 pour l'analyse
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 16-04-2025
##################################################

creer.figure.2 <- function(data){
  
chemin <- "figure_2_obs_par_classe.pdf"
  
  #Figure 2 (Nombre d'observations total par classe)
  pdf(chemin, width = 14, height = 6) #pour exportation de la figure en pdf
  par(mfrow = c(1,1), mar = c(10, 8, 4, 2), mgp = c(5, 1, 0))  # aucun fractionnement de la fenêtre graphique
  
  total_par_classe <- data %>%         # Calcul du total d'observations par classe
    group_by(class) %>%
    summarise(total_obs = sum(Nb_obs)) %>%
    arrange(desc(total_obs))
  
  min_y <- floor(log10(min(total_par_classe$total_obs[total_par_classe$total_obs > 0])))
  max_y <- ceiling(log10(max(total_par_classe$total_obs)))  # Calculer les bornes en log10
  
  barplot(total_par_classe$total_obs,
          names.arg = total_par_classe$class,
          las = 2,                      # rotation des labels pour lisibilité
          col = "skyblue",
          border = "darkblue",
          cex.names = 0.8,
          ylab = "Nombre total d'observations (log10)",
          main = "Observations par classe (échelle logarithmique)",
          log = "y",                    # échelle logarithmique
          ylim = c(10^min_y, 10^max_y)) 

  #Ajoute manuellement le titre de l'axe des X
  mtext("Classe taxonomique", side = 1, line = 6)
  
  dev.off()
  
  return(chemin)
  
}