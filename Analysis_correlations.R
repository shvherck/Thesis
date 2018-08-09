#############################################
###############  Correlations ###############
#############################################

library(gdata)

# read data
rm(list=ls())
D <- read.xls("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_correlatie.xlsx", header = T, fill = T)
head(D)

names(D) <- c("Subject","Group", "SES", "Proficiency_L2","Switch_frequency", "Fluency_L1", "L1_dieren", "L1_groenten", "L1_beroepen", "Fluency_L2", "Switch_proficiency", "Switch_cost", "Simon_congr_RT", "Simon_incongr_RT", "Simon_effect_RT", "Simon_congr_error", "Simon_incongr_error", "Simon_effect_error", "Switch_RT", "Nonswitch_RT", "Switch_cost_RT", "Switch_error", "Nonswitch_error", "Switch_cost_error", "Mixed_RT", "Single_RT", "Mix_cost_RT", "Mixed_error", "Single_error", "Mix_cost_error")
head(D)


###########################################
# Switch frequency vs. switch proficiency #
###########################################

df <- data.frame(D$Switch_frequency, D$Switch_cost)
df

######### outliers verwijderen #########

mean(df$D.Switch_frequency)
sd(df$D.Switch_frequency)
3.41+(2.5*0.51)
3.41-(2.5*0.51)
# geen outliers

mean(df$D.Switch_cost)
sd(df$D.Switch_cost)
13.5+(2.5*5.71)
13.5-(2.5*5.71)
# outliers = 30 (rij 18)

# 1 participant verwijderen: 18
df2 <- df[-c(18), ]
df2
# 18 verwijderd

plot(df2[,1:2])

library("car")
scatterplot(D.Switch_frequency ~ D.Switch_cost, data = df2)

scatterplot(D.Switch_frequency ~ D.Switch_cost, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)

cor(df2,method="pearson")
cor(df2[,1:2],method="spearman")

cor.test(df2$D.Switch_frequency,df2$D.Switch_cost,method="pearson")
# corr -0.05 _ p O.83
cor.test(df2$x,df2$y,method="spearman")


############################
# Switch cost vs. Simon RT #
############################

df <- data.frame(D$Switch_cost, D$Simon_effect_RT, D$SES, D$Proficiency_L2)
df

######### outliers verwijderen #########

mean(df$D.Switch_cost)
sd(df$D.Switch_cost)
# outliers = 30 (rij 18)

mean(na.omit(df$D.Simon_effect_RT))
sd(na.omit(df$D.Simon_effect_RT))
df$D.Simon_effect_RT
31.19+(2.5*34.69)
31.19-(2.5*34.69)
# outliers=  -93.45 + NA (rij 2 en 6)

# 3 participanten verwijderen: 2 6 18

df2 <- df[-c(2, 6, 18), ]
df2

plot(df2[,1:4])

library("car")
scatterplot(D.Simon_effect_RT ~ D.Switch_cost, data = df2)

scatterplot(D.Simon_effect_RT ~ D.Switch_cost, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Simon_effect_RT ~ D.SES, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Simon_effect_RT ~ D.Proficiency_L2, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)

cor(df2,method="pearson")
cor(df2[,1:2],method="spearman")

cor.test(df2$D.Simon_effect_RT,df2$D.Switch_cost,method="pearson")
cor.test(df2$D.Simon_effect_RT,df2$D.SES,method="pearson")
cor.test(df2$D.Simon_effect_RT,df2$D.Proficiency_L2,method="pearson")

  #Simon – switch cost: r = 0.38   p = 0.16
  #Simon – SES: r = 0.61   p = 0.02
  #Simon – L2: r = - 0.19   p = 0.5


model1<-lm(D.Simon_effect_RT ~ D.SES, data = df2)
model2<-lm(D.Simon_effect_RT ~ D.SES + D.Switch_cost, data = df2)
anova(model1, model2) # switch draagt niet bij tot model
model3<-lm(D.Simon_effect_RT ~ D.SES + D.Proficiency_L2, data = df2)
anova(model1, model3) # L2 draagt niet bij tot model
# model 1 is het beste
summary(model1)
par(mfrow=c(2,2))
plot(model1)
# aan voorwaarden voldaan voor lm

  #Model met alleen SES als voorspeller voor Simon effect het beste: p SES = 0.02

###############################
# Switch cost vs. Simon error #
###############################

df <- data.frame(D$Switch_cost, D$Simon_effect_error, D$SES, D$Proficiency_L2)
df

######### outliers verwijderen #########

mean(df$D.Switch_cost)
sd(df$D.Switch_cost)
# outliers = 30

mean(na.omit(df$D.Simon_effect_error))
sd(na.omit(df$D.Simon_effect_error))
df$D.Simon_effect_error
0.03+(2.5*0.03)
0.03-(2.5*0.03)
# geen outliers, maar wel NA (rij 2)

# 2 participanten verwijderen: 2 en 18
df2 <- df[-c(2, 18), ]
df2

plot(df2[,1:4])

library("car")
scatterplot(D.Simon_effect_error ~ D.Switch_cost, data = df2)

scatterplot(D.Simon_effect_error ~ D.Switch_cost, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Simon_effect_error ~ D.SES, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Simon_effect_error ~ D.Proficiency_L2, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)

cor(df2,method="pearson")
cor(df2[,1:2],method="spearman")

cor.test(df2$D.Simon_effect_error,df2$D.Switch_cost,method="pearson")
cor.test(df2$D.Simon_effect_error,df2$D.SES,method="pearson")
cor.test(df2$D.Simon_effect_error,df2$D.Proficiency_L2,method="pearson")

  #Geen significante correlaties

model1<-lm(D.Simon_effect_error ~ 1, data = df2)
model2<-lm(D.Simon_effect_error ~ D.SES, data = df2)
anova(model1, model2) # SES draagt niet bij tot het model
model3<-lm(D.Simon_effect_error ~ D.Switch_cost, data = df2)
anova(model1, model3) # switch cost draagt niet bij tot het model
model4<-lm(D.Simon_effect_error ~ D.Proficiency_L2, data = df2)
anova(model1, model4) # L2 draagt niet bij tot het model

  # Geen relatie tussen simon effect error en de predictoren


#############################
# Switch cost vs. switch RT #
#############################

df <- data.frame(D$Switch_cost, D$Switch_cost_RT, D$SES, D$Proficiency_L2)
df

######### outliers verwijderen #########

mean(df$D.Switch_cost)
sd(df$D.Switch_cost)
# outliers = 30 (rij 18)

mean(na.omit(df$D.Switch_cost_RT))
sd(na.omit(df$D.Switch_cost_RT))
df$D.Switch_cost_RT
126.39+(2.5*66.37)
126.39-(2.5*66.37)
# geen outliers, maar NA op rij 2 en 14

# 3 participanten verwijderen: 2 14 18
df2 <- df[-c(2, 14, 18), ]
df2

plot(df2[,1:4])

library("car")
scatterplot(D.Switch_cost_RT ~ D.Switch_cost, data = df2)

scatterplot(D.Switch_cost_RT ~ D.Switch_cost, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Switch_cost_RT ~ D.SES, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Switch_cost_RT ~ D.Proficiency_L2, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)

cor(df2,method="pearson")
cor(df2[,1:2],method="spearman")

cor.test(df2$D.Switch_cost_RT,df2$D.Switch_cost,method="pearson")
cor.test(df2$D.Switch_cost_RT,df2$D.SES,method="pearson")
cor.test(df2$D.Switch_cost_RT,df2$D.Proficiency_L2,method="pearson")

  #Geen significante correlaties

model1<-lm(D.Switch_cost_RT ~ 1, data = df2)
model2<-lm(D.Switch_cost_RT ~ D.Switch_cost, data = df2)
anova(model1, model2) # Switch cost draagt niet bij tot het model
model3<-lm(D.Switch_cost_RT ~ D.SES, data = df2)
anova(model1, model3) # SES draagt niet bij tot het model
model4<-lm(D.Switch_cost_RT ~ D.Proficiency_L2, data = df2)
anova(model1, model4) # L2 draagt niet bij tot het model

  #Geen relatie tussen Switch cost RT en predictoren


################################
# Switch cost vs. switch error #
################################

df <- data.frame(D$Switch_cost, D$Switch_cost_error, D$SES, D$Proficiency_L2)
df

######### outliers verwijderen #########

mean(df$D.Switch_cost)
sd(df$D.Switch_cost)
# outliers = 30 (rij 18)

mean(na.omit(df$D.Switch_cost_error))
sd(na.omit(df$D.Switch_cost_error))
df$D.Switch_cost_error
0.04+(2.5*0.05)
0.04-(2.5*0.05)
# geen outliers, maar NA op rij 2 en 14

# 3 participanten verwijderen: 2 14 18
df2 <- df[-c(2, 14, 18), ]
df2

plot(df2[,1:4])

library("car")
scatterplot(D.Switch_cost_error ~ D.Switch_cost, data = df2)

scatterplot(D.Switch_cost_error ~ D.Switch_cost, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Switch_cost_error ~ D.SES, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Switch_cost_error ~ D.Proficiency_L2, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)

cor(df2,method="pearson")
cor(df2[,1:2],method="spearman")

cor.test(df2$D.Switch_cost_error,df2$D.Switch_cost,method="pearson")
cor.test(df2$D.Switch_cost_error,df2$D.SES,method="pearson")
cor.test(df2$D.Switch_cost_error,df2$D.Proficiency_L2,method="pearson")

  #Geen significante correlaties

model1<-lm(D.Switch_cost_error ~ 1, data = df2)
model2<-lm(D.Switch_cost_error ~ D.Switch_cost, data = df2)
anova(model1, model2) # Switch cost draagt niet bij tot het model
model3<-lm(D.Switch_cost_error ~ D.SES, data = df2)
anova(model1, model3) # SES draagt niet bij tot het model
model4<-lm(D.Switch_cost_error ~ D.Proficiency_L2, data = df2)
anova(model1, model4) # L2 draagt niet bij tot het model

  #Geen relatie tussen Switch cost RT en predictoren



##########################
# Switch cost vs. Mix RT #
##########################

df <- data.frame(D$Switch_cost, D$Mix_cost_RT, D$SES, D$Proficiency_L2)
df

######### outliers verwijderen #########

mean(df$D.Switch_cost)
sd(df$D.Switch_cost)
# outliers = 30 (rij 18)

mean(na.omit(df$D.Mix_cost_RT))
sd(na.omit(df$D.Mix_cost_RT))
df$D.Mix_cost_RT
121.16+(2.5*127.50)
121.16-(2.5*127.50)
# geen outliers, maar NA op rij 2 en 14

# 3 participanten verwijderen: 2 14 18
df2 <- df[-c(2, 14, 18), ]
df2

plot(df2[,1:4])

library("car")
scatterplot(D.Mix_cost_RT ~ D.Switch_cost, data = df2)

scatterplot(D.Mix_cost_RT ~ D.Switch_cost, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Mix_cost_RT ~ D.SES, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Mix_cost_RT ~ D.Proficiency_L2, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)

cor(df2,method="pearson")
cor(df2[,1:2],method="spearman")

cor.test(df2$D.Mix_cost_RT,df2$D.Switch_cost,method="pearson")
cor.test(df2$D.Mix_cost_RT,df2$D.SES,method="pearson")
cor.test(df2$D.Mix_cost_RT,df2$D.Proficiency_L2,method="pearson")

  #Geen significante correlaties

model1<-lm(D.Mix_cost_RT ~ 1, data = df2)
model2<-lm(D.Mix_cost_RT ~ D.Switch_cost, data = df2)
anova(model1, model2) # Switch cost draagt niet bij tot het model
model3<-lm(D.Mix_cost_RT ~ D.SES, data = df2)
anova(model1, model3) # SES draagt niet bij tot het model
model4<-lm(D.Mix_cost_RT ~ D.Proficiency_L2, data = df2)
anova(model1, model4) # L2 draagt niet bij tot het model

  #Geen relatie tussen Switch cost RT en predictoren


#############################
# Switch cost vs. Mix error #
#############################

df <- data.frame(D$Switch_cost, D$Mix_cost_error, D$SES, D$Proficiency_L2)
df

######### outliers verwijderen #########

mean(df$D.Switch_cost)
sd(df$D.Switch_cost)
# outliers = 30 (rij 18)

df$D.Mix_cost_error
mean(na.omit(df$D.Mix_cost_error))
sd(na.omit(df$D.Mix_cost_error))
df$Mix_cost_error
-0.003+(2.5*0.04)
-0.003-(2.5*0.04)
# outliers = -0.12 en 2 en 14 zijn NA (rij 2, 7, 14)

# 3 participanten verwijderen: 2 7 14 18
df2 <- df[-c(2, 7, 14, 18), ]
df2

plot(df2[,1:4])

library("car")
scatterplot(D.Mix_cost_error ~ D.Switch_cost, data = df2)

scatterplot(D.Mix_cost_error ~ D.Switch_cost, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Mix_cost_error ~ D.SES, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)
scatterplot(D.Mix_cost_error ~ D.Proficiency_L2, data = df2, smoother = FALSE, grid = FALSE, frame = FALSE)

cor(df2,method="pearson")
cor(df2[,1:2],method="spearman")

cor.test(df2$D.Mix_cost_error,df2$D.Switch_cost,method="pearson")
cor.test(df2$D.Mix_cost_error,df2$D.SES,method="pearson")
cor.test(df2$D.Mix_cost_error,df2$D.Proficiency_L2,method="pearson")

  #Geen significante correlaties 

model1<-lm(D.Mix_cost_error ~ 1, data = df2)
model2<-lm(D.Mix_cost_error ~ D.Switch_cost, data = df2)
anova(model1, model2) # Switch cost draagt niet bij tot het model
model3<-lm(D.Mix_cost_error ~ D.SES, data = df2)
anova(model1, model3) # SES draagt niet bij tot het model
model4<-lm(D.Mix_cost_error ~ D.Proficiency_L2, data = df2)
anova(model1, model4) # L2 draagt niet bij tot het model

  #Geen relatie tussen Switch cost RT en predictoren
