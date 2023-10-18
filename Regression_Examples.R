
### REGRESSIONS -------------------------------------------------------------------------------------
# Binomial logistic regression (dichotomous outcome)
binom_mod <- glm(outcome ~ predictors, data = data, weights = weight, family = 'binomial')

# Multinomial logistic regression (unordered outcome)
library(nnet)
multi_mod <- multinom(outcome ~ predictors, data = data, weights = weight)

# Ordinal logistic regression (ordered outcome)
library(MASS)
ord_mod <- polr(outcome ~ predictors, data = data, weights = weight)
poTest(Model1) # test of parallel lines

# Negative Binomial (count outcome, disperson stat <1)
library(MASS)
nb_mod <- glm.nb(outcome ~ predictors, data = data, weights = weight)
nboff_mod <- glm.nb(outcome ~ predictors + offset(predictor2), data = data, weights = weight) # offset used when unequal opportunity for each count based on another var (e.g., unequal opportunity to get rearrested based on how long you are out of jail)

# Hurdle (count, structural 0s, i.e., reason why a count could not occur)
library(pscl)
hurd_mod <- hurdle(outcome ~ predictors, data = data, dist = 'negbin') # first set of coefs = interpeted as normal count model; # second set of coefs = interpreted as likelihood of crossing hurdle and interpreted like binomial logit

# Zero Inflated (count, both structural and non-structural 0s)
library(pscl)
zero_mod <- zeroinfl(outcome ~ predictors, data = data, dist = 'negbin')

# Panel linear model
library(plm)
panel_mod <- plm(outcome ~ predictors, model = 'within', index = 'variable') # "within" is fixed effects and "random" is random effects"

# Instrumental variable with 2SLS
library(AER)
iv_mod <- ivreg(outcome ~ predictors | instruments, 

### HELPFUL TOOLS-------------------------------------------------------------------------------------------------------
# Odds ratios (convert unstandardized log odds output into standardized odds ratios)
library(sjPlot)
tab_model(model)

# Model comparison 
anova(model1, model2, test = 'LRT') # ANOVA
AIC(model1, model2) # for misc. count models
phtest(model1, model2) # for panel models, e.g., comparing fixed vs random effects

# R Squared
DescTools::PseudoR2(model, c("Nagelkerke"))   

# Marginal effects
AME <- margins::margins(model)

# Cluster standard errors
library(lmtest)
library(sandwich)
coeftest(model, vcov. = vcovCL(model, cluster = ~ predictor))
summary(model, vcov = vcovHC(model, type = "sss", cluster = "group"))

# Robust standard errors
summary(model, vcov. = vcovHC(model, type = "HC1"))

# IV overidentification test (tests if exogeneous relationship between instrument and outcome
summary(model, vcov. = vcovHC(model, type = "HC1"), diagnostics = TRUE)


