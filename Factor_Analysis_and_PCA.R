## Exploratory factor analysis example
library(psych) # To run EFA
library(REdaS) # KMO & Bartletts test

econ16 <- sd16 %>% dplyr::select(AMU304, AMU302, AMU305, AMU303, AMU301)

KMO(econ16)
bart_spher(econ16, use = 'complete.obs')
fa(econ16, nfactors = ncol(econ16), rotate = 'oblimin') # 1

## PCA Example
library(psych)
relevant_data <- c20[, c("gsamb", "abortamb", "ambecon")]
pca_result <- principal(relevant_data, nfactors = 1, rotate = "none"); pca_result

loadings <- pca_result$loadings                        
pca_result$values                                      # gets eigenvalue; wants greater than 1 (labeled SS loadings)
weights <- loadings[,1]
scale_scores <- as.matrix(relevant_data) %*% weights   # create weighted scale

