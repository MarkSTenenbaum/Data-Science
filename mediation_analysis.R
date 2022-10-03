# Mediation analysis example with `mediation` package
library(mediation)
wc9 <- lm(Status.Threat.Relig ~ Treatment+ Age + Education + Income + Male + South+ educationdummy + incomedummy, white.plur2)
wc10 <- lm(Anti.Help.Black ~ Treatment + Status.Threat.Relig+ Age + Education + Income + Male + South+ educationdummy + incomedummy, white.plur2)
wc_plur2_med <- mediate(wc9, wc10, treat = 'Treatment', 
                      mediator = 'Status.Threat.Relig',
                      boot = T, sims = 500)
summary(wc_plur2_med)
