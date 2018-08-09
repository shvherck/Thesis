# Load packages 
library(mlmRev)
library(reshape)
library(lattice)
library(car)
library(lme4)
library(leaps)
library(MASS)
library(gdata)
# to read xlsx files

# Read data
rm(list=ls())
D <- read.xls("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_ppn.xlsx", header = T, fill = T)
head(D)

names(D) <- c("Subject","Group", "SES", "Proficiency_L2","Switch_frequency", "Fluency_L1", "L1_dieren", "L1_groenten", "L1_beroepen", "Fluency_L2", "Switch_proficiency", "Switch_cost", "Simon_congr_RT", "Simon_incongr_RT", "Simon_effect_RT", "Simon_congr_error", "Simon_incongr_error", "Simon_effect_error", "Switch_RT", "Nonswitch_RT", "Switch_cost_RT", "Switch_error", "Nonswitch_error", "Switch_cost_error", "Mixed_RT", "Single_RT", "Mix_cost_RT", "Mixed_error", "Single_error", "Mix_cost_error")
head(D)



# Separate Groups 1 and 2
D_bi <- subset(D, Group == 2)
D_bi
D_mono <- subset(D, Group == 1)
D_mono

########################
# Proficiency analyses #
########################
Prof_bi <- D_bi$Proficiency_L2
Prof_bi
Prof_mono <- D_mono$Proficiency_L2
Prof_mono

mean(Prof_bi)
sd(Prof_bi)

mean(Prof_mono)
sd(Prof_mono)

# testing for equal variances
var.test(Prof_bi, Prof_mono)
# p-value not significant -> variances are equal

# t-test
t.test(Prof_bi, Prof_mono, var.equal = TRUE, paired = FALSE)
# p = 0.000*** -> bi scores significantly higher than mono

###########################
# Proficiency analyses L1 #
###########################
L1_bi <- D_bi$Fluency_L1
L1_bi
L1_mono <- D_mono$Fluency_L1
L1_mono

mean(L1_bi)
sd(L1_bi)

mean(L1_mono)
sd(L1_mono)

# testing for equal variances
var.test(L1_bi, L1_mono)
# p-value  significant -> variances are not equal

# t-test
t.test(L1_bi, L1_mono, var.equal = FALSE, paired = FALSE)
# p = 0.79 -> the amount of exemplars produced in the L1 condition did not significantly differ between groups

########
# SVFT #
########

Dieren <- D_mono$L1_dieren
Dieren
Groenten <- D_mono$L1_groenten
Groenten
Beroepen <- D_mono$L1_beroepen
Beroepen

t.test(Dieren, Groenten, var.equal=TRUE, paired=FALSE)
t.test(Dieren, Beroepen, var.equal=TRUE, paired=FALSE)
t.test(Groenten, Beroepen, var.equal=TRUE, paired=FALSE)



# Read data
rm(list=ls())
D <- read.xls("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_ppn_sectie.xlsx", header = T, fill = T)
head(D)

names(D) <- c("Subject","Group", "Age", "SES", "L1_proficiency", "L1_AOA", "L1_use", "L2_proficiency", "L2_AOA", "L2_use", "Switch_frequency", "Fluency_L1", "Fluency_L2", "Switch_cost")
head(D)

D_bi <- subset(D, Group == 2)
D_bi
D_mono <- subset(D, Group == 1)
D_mono

#######
# Age #
#######

Age_bi <- D_bi$Age
Age_bi
Age_mono <- D_mono$Age
Age_mono

mean(na.omit(Age_bi))
sd(na.omit(Age_bi))

mean(na.omit(Age_mono))
sd(na.omit(Age_mono))

# testing for equal variances
var.test(Age_bi, Age_mono)
# p-value significant -> variances are not equal

# t-test
t.test(Age_bi, Age_mono, var.equal = FALSE, paired = FALSE)


##################
# L1 proficiency #
##################

L1prof_bi <- D_bi$L1_proficiency
L1prof_bi
L1prof_mono <- D_mono$L1_proficiency
L1prof_mono

mean(na.omit(L1prof_bi))
sd(na.omit(L1prof_bi))

mean(na.omit(L1prof_mono))
sd(na.omit(L1prof_mono))

# testing for equal variances
var.test(L1prof_bi, L1prof_mono)
# p-value not significant -> variances are equal

# t-test
t.test(L1prof_bi, L1prof_mono, var.equal = TRUE, paired = FALSE)

##########
# L1 AOA #
##########

L1AOA_bi <- D_bi$L1_AOA
L1AOA_bi
L1AOA_mono <- D_mono$L1_AOA
L1AOA_mono

mean(na.omit(L1AOA_bi))
sd(na.omit(L1AOA_bi))

mean(na.omit(L1AOA_mono))
sd(na.omit(L1AOA_mono))

# testing for equal variances
var.test(L1AOA_bi, L1AOA_mono)
# p-value not significant -> variances are equal

# t-test
t.test(L1AOA_bi, L1AOA_mono, var.equal = TRUE, paired = FALSE)

##########
# L1 use #
##########

L1use_bi <- D_bi$L1_use
L1use_bi
L1use_mono <- D_mono$L1_use
L1use_mono

mean(na.omit(L1use_bi))
sd(na.omit(L1use_bi))

mean(na.omit(L1use_mono))
sd(na.omit(L1use_mono))

# testing for equal variances
var.test(L1use_bi, L1use_mono)
# p-value not significant -> variances are equal

# t-test
t.test(L1use_bi, L1use_mono, var.equal = TRUE, paired = FALSE)


##################
# L2 proficiency #
##################

L2prof_bi <- D_bi$L2_proficiency
L2prof_bi
L2prof_mono <- D_mono$L2_proficiency
L2prof_mono

mean(na.omit(L2prof_bi))
sd(na.omit(L2prof_bi))

mean(na.omit(L2prof_mono))
sd(na.omit(L2prof_mono))

# testing for equal variances
var.test(L2prof_bi, L2prof_mono)
# p-value not significant -> variances are equal

# t-test
t.test(L2prof_bi, L2prof_mono, var.equal = TRUE, paired = FALSE)

##########
# L1 AOA #
##########

L2AOA_bi <- D_bi$L2_AOA
L2AOA_bi
L2AOA_mono <- D_mono$L2_AOA
L2AOA_mono

mean(na.omit(L2AOA_bi))
sd(na.omit(L2AOA_bi))

mean(na.omit(L2AOA_mono))
sd(na.omit(L2AOA_mono))

# testing for equal variances
var.test(L2AOA_bi, L2AOA_mono)
# p-value significant -> variances are not equal

# t-test
t.test(L2AOA_bi, L2AOA_mono, var.equal = FALSE, paired = FALSE)

##########
# L2 use #
##########

L2use_bi <- D_bi$L2_use
L2use_bi
L2use_mono <- D_mono$L2_use
L2use_mono

mean(na.omit(L2use_bi))
sd(na.omit(L2use_bi))

mean(na.omit(L2use_mono))
sd(na.omit(L2use_mono))

# testing for equal variances
var.test(L2use_bi, L2use_mono)
# p-value not significant -> variances are equal

# t-test
t.test(L2use_bi, L2use_mono, var.equal = TRUE, paired = FALSE)


##############
# L1 fluency #
##############

L1fluency_bi <- D_bi$Fluency_L1
L1fluency_bi
L1fluency_mono <- D_mono$Fluency_L1
L1fluency_mono

mean(na.omit(L1fluency_bi))
sd(na.omit(L1fluency_bi))

mean(na.omit(L1fluency_mono))
sd(na.omit(L1fluency_mono))

# testing for equal variances
var.test(L1fluency_bi, L1fluency_mono)
# p-value significant -> variances are not equal

# t-test
t.test(L1fluency_bi, L1fluency_mono, var.equal = FALSE, paired = FALSE)

##############
# L1 fluency #
##############

L2fluency_bi <- D_bi$Fluency_L2
L2fluency_bi

mean(na.omit(L2fluency_bi))
sd(na.omit(L2fluency_bi))

###############
# Switch cost #
###############

Switch_cost <- D_bi$Switch_cost
Switch_cost

mean(na.omit(Switch_cost))
sd(na.omit(Switch_cost))

#######
# SES #
#######

SES_bi <- D_bi$SES
SES_bi
SES_mono <- D_mono$SES
SES_mono

mean(na.omit(SES_bi))
sd(na.omit(SES_bi))

mean(na.omit(SES_mono))
sd(na.omit(SES_mono))

# testing for equal variances
var.test(SES_bi, SES_mono)
# p-value significant -> variances are not equal

# t-test
t.test(SES_bi, SES_mono, var.equal = FALSE, paired = FALSE)






