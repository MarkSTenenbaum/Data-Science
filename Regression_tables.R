# Stargazer example
stargazer(mod4_imm_lgb_20, mod4_imm_trans_20, mod4_evn_lgb_20, mod4_evn_trans_20, mod4_wage_lgb_20, mod4_wage_trans_20, type = 'text',
          dep.var.caption = '2020',
          dep.var.labels = c('Immigration', "Environment", 'Minimum Wage'),
          model.names = F,
          column.labels = c('LGB', 'Transgender','LGB', 'Transgender','LGB', 'Transgender'), 
          covariate.labels = c('Age', 'White', 'Education', 'Income', 'Attendance', 'Party ID', 'Male',
                               'LGB', 'Transgender', 'Catholic', 'Evangelical', 'Mainline', 'Other',
                               'LGB*Catholic', 'LGB*Evangelical', 'LGB*Mainline', 'LGB*Other', 
                               'Trans*Catholic', 'Trans*Evangelical', 'Trans*Mainline', 'Trans*Other',
                               'Constant'),
          out = 'issues20SUPPLEMENTAL.htm')
          
          

# Getting predicted values example
library(sjPlot)
get_model_data(mod1_lib_lgb_16, type = 'pred',  terms = c('trad', 'LGB[0,1]'))


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

