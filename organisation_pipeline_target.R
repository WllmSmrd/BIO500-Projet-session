##ORGANISATION DU PIPELINE TARGET########################

##Path

##Importation données 
  #taxonomie
    #target: étape 1

  #observations
   #target: étape 2


##Nettoyage données
  #observations
    #target: étapes 3 à 10 et 13

  #taxonomie
    #étapes 11, 12, 14

##Préparation des données observations pour injection
  #target: étape 15
  #target: étape 16

##Creation base de données SQL et injection
  #target: étapes abondances_bd (pas de # d'étape) et 17 à 19
  #target: étapes 20-21

##Extraction de données pour l'analyse
  #données biodiversité
    #target: étape 22

  #données observations par taxons
    #target: étape 23


##Analyses et visualisation
  #Figure 1
    #étape 24
  
  #Figures 2-3
    #étape 25
