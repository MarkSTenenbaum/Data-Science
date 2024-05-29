## Exploratory factor analysis example
library(psych) # To run EFA
library(REdaS) # KMO & Bartletts test

econ16 <- sd16 %>% dplyr::select(AMU304, AMU302, AMU305, AMU303, AMU301)

KMO(econ16)
bart_spher(econ16, use = 'complete.obs')
fa(econ16, nfactors = ncol(econ16), rotate = 'oblimin') # 1

## PCA Example
library(psych)
moddata <- c20 %>% dplyr::select(ideo_fold, pid_fold, approve_fold)
modpca <- principal(moddata, nfactors = 1, rotate = "none")
modloads <- modpca$loadings
modweights <- modloads[,1]
mod_new <- as.matrix(moddata) %*% modweights
c20 <- c20 %>% mutate(modindexpca = mod_new/2.805659)

