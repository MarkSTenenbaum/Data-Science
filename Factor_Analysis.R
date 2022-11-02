## Exploratory factor analysis example
library(psych) # To run EFA
library(REdaS) # KMO & Bartletts test

# 2016 (Figure 2)
econ16 <- sd16 %>% dplyr::select(AMU304, AMU302, AMU305, AMU303, AMU301)
gender16 <- sd16 %>% dplyr::select(AMU314, AMU312, AMU315, AMU313, AMU311)
racial16 <- sd16 %>% dplyr::select(AMU309, AMU307,AMU3010, AMU308, AMU306)

KMO(econ16)
bart_spher(econ16, use = 'complete.obs')
fa(econ16, nfactors = ncol(econ16), rotate = 'oblimin') # 1

KMO(gender16)
bart_spher(gender16, use = 'complete.obs')
fa(gender16, nfactors = ncol(gender16), rotate = 'oblimin') # 2


KMO(racial16)
bart_spher(racial16, use = 'complete.obs')
fa(racial16, nfactors = ncol(racial16), rotate = 'oblimin') # 1
