##################################################
# Exécution du pipeline target                           
#
# Auteur: William Simard, Zoé Chol, Kyara Boisvert 
# Date: 21-04-2025
##################################################

library(targets)
tinytex:::install_prebuilt()
tar_make()
tar_visnetwork()


