##################################################
# Fonction qui permet de créer les figures 2 et 3 pour l'analyse
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 16-04-2025
##################################################

creer.figures.2.3 <- function(data){
  
  #Figure 2 (Nombre d'observations total par classe)
  pdf("figure_2_obs_par_classe.pdf", width = 14, height = 6) #pour exportation de la figure en pdf
  par(mfrow = c(1,1), mar = c(10, 6, 4, 2), mgp = c(4, 1, 0))                  # aucun fractionnement de la fenêtre graphique
  
  total_par_classe <- data %>%         # Calcul du total d'observations par classe
    group_by(class) %>%
    summarise(total_obs = sum(Nb_obs)) %>%
    arrange(desc(total_obs))
  
  barplot(total_par_classe$total_obs,
          names.arg = total_par_classe$class,
          las = 2,                      # rotation des labels pour lisibilité
          col = "skyblue",
          border = "darkblue",
          cex.names = 0.8,
          ylab = "Nombre total d'observations (log10)",
          main = "Observations par classe (échelle logarithmique)",
          log = "y")                    # échelle logarithmique
  
  mtext("Classe taxonomique", side = 1, line = 6)
  
  dev.off()
  
  
  #Figure 3 (déclin des taxons dans un intervalle de temps à déterminer)
  pdf("figure_3_declin_classe.pdf", width = 14, height = 6) #pour exportation de la figure en pdf
  par(mfrow = c(1,1), mar = c(10, 6, 4, 2), mgp = c(4, 1, 0))                  # aucun fractionnement de la fenêtre graphique

  obs_comparaison_1970 <- obs_years_taxon %>%
    filter(!is.na(years), years >= 1970, !is.na(Nb_obs)) %>%
    group_by(class) %>%
    arrange(years) %>%
    summarise(
      annee_debut = first(years),
      obs_debut = first(Nb_obs),
      annee_fin = last(years),
      obs_fin = last(Nb_obs),
      variation = obs_fin - obs_debut,
      variation_pourcent = 100 * (obs_fin - obs_debut) / obs_debut,
      .groups = "drop"
    )
  
  #Créer le barplot et stocker les positions des barres
  bar_positions <- barplot(obs_comparaison_1970$variation_pourcent,
                           names.arg = obs_comparaison_1970$class,
                           col = ifelse(obs_comparaison_1970$variation_pourcent < 0, "red", "green"),
                           main = "Variation des observations par classe depuis 1970",
                           ylab = "Variation (%)",
                           las = 2,
                           cex.names = 0.7,
                           border = "black",
                           ylim = c(-200, 600))
  
  mtext("Classe taxonomique", side = 1, line = 6)
  
  #Ajouter les valeurs numériques arrondies (entiers)
  text(x = bar_positions,
       y = obs_comparaison_1970$variation_pourcent,
       labels = round(obs_comparaison_1970$variation_pourcent),
       pos = ifelse(obs_comparaison_1970$variation_pourcent >= 0, 3, 1),
       cex = 0.7)
  
  dev.off()
}