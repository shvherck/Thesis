library(mlmRev)
library(reshape)
library(lattice)
library(car)
library(lme4)
library(leaps)
library(MASS)
library(gdata)
library(Rmisc)
library(ggplot2)

###############################################
########  Analyse bilingual advantage #########
###############################################

##################################
### Bilingual advantage Simon  ###
##################################

### RT ###

S_RT = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_S_RT.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(S_RT)

S_RT$fsubject  <- paste("S",factor(S_RT$participant), sep="")
S_RT$fgroup <- factor(S_RT$group, levels = c(1,2), labels = c("monolingual", "bilingual"))
S_RT$fcongruency <- factor(S_RT$congruency, levels = c(0,1), labels = c("incongruent", "congruent"))
S_RT$accuracy <- factor(S_RT$accuracy, levels = c(0,1), labels = c("wrong", "correct"))

## repeated measures ANOVA
S_RT.melt <- melt(S_RT, id.var=c("fsubject","fgroup","fcongruency"),measure.var=c("rt"))
head(S_RT.melt)
S_RT.wide <- cast(fsubject + fgroup ~ fcongruency, data=S_RT.melt, mean)
head(S_RT.wide)

congruency <- factor(rep(1:2, times=1))
idata <- data.frame(congruency)
idata

options(contrasts=c("contr.sum", "contr.poly"))
fit <- lm( cbind(incongruent, congruent) ~ fgroup, data=S_RT.wide)
out <- Anova(fit, type="III", test="Wilks", idata=idata, idesign=~congruency)
summary(out, multivariate=FALSE, univariate=TRUE)

  # Plot bilingual advantage simon rt
  data.plot.simonrt    <- cast(S_RT.melt, fgroup*fcongruency ~ ., mean)
  names(data.plot.simonrt)[3] <- "rt"
  data.plot.simonrt
  print(xyplot(rt ~ fcongruency, groups = fgroup, type=c("g", "b"), auto.key=list(colums=2, corner=c(0.1,0.9),lines=T), data=data.plot.simonrt, ylim = c(400, 500), main = "Group x congruency", xlab = "Congruency", ylab = "Mean RT"))

  SEplot <- summarySE(S_RT, measurevar="rt", groupvars=c("fgroup", "fcongruency"))
  SEplot
  names(SEplot)[1] <- "group"
  names(SEplot)[2] <- "congruency"
  SEplot

  ggplot(SEplot, aes(x=congruency ,y=rt, color = group, group = group)) + ylim(400, 500) + geom_errorbar(aes(ymin=rt-se, ymax=rt+se), width=.1) + geom_line() + geom_point() + theme(panel.background = element_rect(fill = 'white', colour = 'grey')) + ggtitle("Group x congruency")


### error ###

S_error = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_S_error.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(S_error)

S_error$fsubject  <- paste("S",factor(S_error$participant), sep="")
S_error$fgroup <- factor(S_error$group, levels = c(1,2), labels = c("monolingual", "bilingual"))
S_error$fcongruency <- factor(S_error$congruency, levels = c(0,1), labels = c("incongruent", "congruent"))

## repeated measures ANOVA
S_error.melt <- melt(S_error, id.var=c("fsubject","fgroup","fcongruency"),measure.var=c("accuracy"))
head(S_error.melt)
S_error.wide <- cast(fsubject + fgroup ~ fcongruency, data=S_error.melt, mean)
head(S_error.wide)

congruency <- factor(rep(1:2, times=1))
idata <- data.frame(congruency)
idata

options(contrasts=c("contr.sum", "contr.poly"))
fit <- lm( cbind(incongruent, congruent) ~ fgroup, data=S_error.wide)
out <- Anova(fit, type="III", test="Wilks", idata=idata, idesign=~congruency)
summary(out, multivariate=FALSE, univariate=TRUE)

  # Plot bilingual advantage simon error
  data.plot.simonerror    <- cast(S_error.melt, fgroup*fcongruency ~ ., mean)
  names(data.plot.simonerror)[3] <- "accuracy"
  data.plot.simonerror
  print(xyplot(accuracy ~ fcongruency, groups = fgroup, type=c("g", "b"), auto.key=list(colums=2, corner=c(0.1,0.9),lines=T), data=data.plot.simonerror, ylim = c(0.9, 1), main = "Group x congruency", xlab = "Congruency", ylab = "Mean error rate"))

  SEplot <- summarySE(S_error, measurevar="accuracy", groupvars=c("fgroup", "fcongruency"))
  SEplot
  names(SEplot)[1] <- "group"
  names(SEplot)[2] <- "congruency"
  SEplot

  ggplot(SEplot, aes(x=congruency ,y=accuracy, color = group, group = group)) + ylim(0.9, 1) + geom_errorbar(aes(ymin=accuracy-se, ymax=accuracy+se), width=.1) + geom_line() + geom_point() + theme(panel.background = element_rect(fill = 'white', colour = 'grey')) + ggtitle("Group x congruency")


###################################
### Bilingual advantage Switch  ###
###################################

### RT ###

CS_RT = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS_RT.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(CS_RT)

CS_RT_switch <- subset(CS_RT, block == 1)
head(CS_RT_switch)

CS_RT_switch$fsubject  <- paste("S",factor(CS_RT_switch$participant), sep="")
CS_RT_switch$fgroup <- factor(CS_RT_switch$group, levels = c(1,2), labels = c("monolingual", "bilingual"))
CS_RT_switch$fblock <- factor(CS_RT_switch$block, levels = c(0,1), labels = c("single", "mixed"))
CS_RT_switch$fswitch <- factor(CS_RT_switch$switch, levels = c(0,1), labels = c("nonswitch", "switch"))

## repeated measures ANOVA
CS_RT_switch.melt <- melt(CS_RT_switch, id.var=c("fsubject", "fgroup", "fswitch"),measure.var=c("rt"))
head(CS_RT_switch.melt)
CS_RT_switch.wide <- cast(fsubject + fgroup ~ fswitch, data=CS_RT_switch.melt, mean)
head(CS_RT_switch.wide)

switch <- factor(rep(1:2, times=1))
idata <- data.frame(switch)
idata

options(contrasts=c("contr.sum", "contr.poly"))
fit <- lm( cbind(nonswitch, switch) ~ fgroup, data=CS_RT_switch.wide)
out <- Anova(fit, type="III", test="Wilks", idata=idata, idesign=~switch)
summary(out, multivariate=FALSE, univariate=TRUE)

  # Plot bilingual advantage switch rt
  data.plot.switchrt    <- cast(CS_RT_switch.melt, fgroup*fswitch ~ ., mean)
  names(data.plot.switchrt)[3] <- "rt"
  data.plot.switchrt
  print(xyplot(rt ~ fswitch, groups = fgroup, type=c("g", "b"), auto.key=list(colums=2, corner=c(0.1,0.9),lines=T), data=data.plot.switchrt, ylim = c(600, 1000), main = "Switch RT", xlab = "Switch", ylab = "Mean RT"))

  SEplot <- summarySE(CS_RT_switch, measurevar="rt", groupvars=c("fgroup", "fswitch"))
  SEplot
  names(SEplot)[1] <- "group"
  names(SEplot)[2] <- "switch"
  SEplot
  
  ggplot(SEplot, aes(x=switch ,y=rt, color = group, group = group)) + ylim(600, 1000) + geom_errorbar(aes(ymin=rt-se, ymax=rt+se), width=.1) + geom_line() + geom_point() + theme(panel.background = element_rect(fill = 'white', colour = 'grey')) + ggtitle("Group x switch")


### error ###
  
CS_error = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS_error.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(CS_error)
CS_error

CS_error_switch <- subset(CS_error, block == 1)
head(CS_error_switch)

CS_error_switch$fsubject  <- paste("S",factor(CS_error_switch$participant), sep="")
CS_error_switch$fgroup <- factor(CS_error_switch$group, levels = c(1,2), labels = c("monolingual", "bilingual"))
CS_error_switch$fblock <- factor(CS_error_switch$block, levels = c(0,1), labels = c("single", "mixed"))
CS_error_switch$fswitch <- factor(CS_error_switch$switch, levels = c(0,1), labels = c("nonswitch", "switch"))
head(CS_error_switch) 
 
## repeated measures ANOVA
CS_error_switch.melt <- melt(CS_error_switch, id.var=c("fsubject", "fgroup", "fswitch"),measure.var=c("accuracy"))
head(CS_error_switch.melt)
CS_error_switch.wide <- cast(fsubject + fgroup ~ fswitch, data=CS_error_switch.melt, mean)
head(CS_error_switch.wide)
CS_error_switch.wide
  
switch <- factor(rep(1:2, times=1))
idata <- data.frame(switch)
idata
  
options(contrasts=c("contr.sum", "contr.poly"))
fit <- lm( cbind(nonswitch, switch) ~ fgroup, data=CS_error_switch.wide)
out <- Anova(fit, type="III", test="Wilks", idata=idata, idesign=~switch)
summary(out, multivariate=FALSE, univariate=TRUE)

  # Plot bilingual advantage switch error
  data.plot.switcherror    <- cast(CS_error_switch.melt, fgroup*fswitch ~ ., mean)
  names(data.plot.switcherror)[3] <- "accuracy"
  data.plot.switcherror
  print(xyplot(accuracy ~ fswitch, groups = fgroup, type=c("g", "b"), auto.key=list(colums=2, corner=c(0.1,0.9),lines=T), data=data.plot.switcherror, ylim = c(0.8, 1), main = "Switch error", xlab = "Switch", ylab = "Mean error rate"))

  SEplot <- summarySE(CS_error_switch, measurevar="accuracy", groupvars=c("fgroup", "fswitch"))
  SEplot
  names(SEplot)[1] <- "group"
  names(SEplot)[2] <- "switch"
  SEplot

  ggplot(SEplot, aes(x=switch ,y=accuracy, color = group, group = group)) + ylim(0.8, 1) + geom_errorbar(aes(ymin=accuracy-se, ymax=accuracy+se), width=.1) + geom_line() + geom_point() + theme(panel.background = element_rect(fill = 'white', colour = 'grey')) + ggtitle("Switch error")


  
################################
### Bilingual advantage Mix  ###
################################

### RT ###

CS_RT = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS_RT.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(CS_RT)

CS_RT_mix <- subset(CS_RT, switch == 0)
CS_RT_mix

CS_RT_mix$fsubject  <- paste("S",factor(CS_RT_mix$participant), sep="")
CS_RT_mix$fgroup <- factor(CS_RT_mix$group, levels = c(1,2), labels = c("monolingual", "bilingual"))
CS_RT_mix$fblock <- factor(CS_RT_mix$block, levels = c(0,1), labels = c("single", "mixed"))
CS_RT_mix$fswitch <- factor(CS_RT_mix$switch, levels = c(0,1), labels = c("nonswitch", "switch"))
head(CS_RT_mix)

## repeated measures ANOVA
CS_RT_mix.melt <- melt(CS_RT_mix, id.var=c("fsubject", "fgroup", "fblock"),measure.var=c("rt"))
head(CS_RT_mix.melt)
CS_RT_mix.wide <- cast(fsubject + fgroup ~ fblock, data=CS_RT_mix.melt, mean)
head(CS_RT_mix.wide)

mix <- factor(rep(1:2, times=1))
idata <- data.frame(mix)
idata

options(contrasts=c("contr.sum", "contr.poly"))
fit <- lm( cbind(single, mixed) ~ fgroup, data=CS_RT_mix.wide)
out <- Anova(fit, type="III", test="Wilks", idata=idata, idesign=~mix)
summary(out, multivariate=FALSE, univariate=TRUE)

  # Plot bilingual advantage mix rt
  data.plot.mixrt    <- cast(CS_RT_mix.melt, fgroup*fblock ~ ., mean)
  names(data.plot.mixrt)[3] <- "rt"
  data.plot.mixrt
  print(xyplot(rt ~ fblock, groups = fgroup, type=c("g", "b"), auto.key=list(colums=2, corner=c(0.1,0.9),lines=T), data=data.plot.mixrt, ylim = c(500, 800), main = "Mix RT", xlab = "Mix", ylab = "Mean RT"))

  SEplot <- summarySE(CS_RT_mix, measurevar="rt", groupvars=c("fgroup", "fblock"))
  SEplot
  names(SEplot)[1] <- "group"
  names(SEplot)[2] <- "block"
  SEplot

  ggplot(SEplot, aes(x=block ,y=rt, color = group, group = group)) + ylim(500, 800) + geom_errorbar(aes(ymin=rt-se, ymax=rt+se), width=.1) + geom_line() + geom_point() + theme(panel.background = element_rect(fill = 'white', colour = 'grey')) + ggtitle("Mix RT")



### error ###

CS_error = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS_error.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(CS_error)


CS_error_mix <- subset(CS_error, switch == 0)
head(CS_error_mix)

CS_error_mix$fsubject  <- paste("S",factor(CS_error_mix$participant), sep="")
CS_error_mix$fgroup <- factor(CS_error_mix$group, levels = c(1,2), labels = c("monolingual", "bilingual"))
CS_error_mix$fblock <- factor(CS_error_mix$block, levels = c(0,1), labels = c("single", "mixed"))
CS_error_mix$fswitch <- factor(CS_error_mix$switch, levels = c(0,1), labels = c("nonswitch", "switch"))
head(CS_error_mix) 

## repeated measures ANOVA
CS_error_mix.melt <- melt(CS_error_mix, id.var=c("fsubject", "fgroup", "fblock"),measure.var=c("accuracy"))
head(CS_error_mix.melt)
CS_error_mix.wide <- cast(fsubject + fgroup ~ fblock, data=CS_error_mix.melt, mean)
head(CS_error_mix.wide)
CS_error_mix.wide

mix <- factor(rep(1:2, times=1))
idata <- data.frame(mix)
idata

options(contrasts=c("contr.sum", "contr.poly"))
fit <- lm( cbind(single, mixed) ~ fgroup, data=CS_error_mix.wide)
out <- Anova(fit, type="III", test="Wilks", idata=idata, idesign=~mix)
summary(out, multivariate=FALSE, univariate=TRUE)

  # Plot bilingual advantage mix error
  data.plot.mixerror    <- cast(CS_error_mix.melt, fgroup*fblock ~ ., mean)
  names(data.plot.mixerror)[3] <- "accuracy"
  data.plot.mixerror
  print(xyplot(accuracy ~ fblock, groups = fgroup, type=c("g", "b"), auto.key=list(colums=2, corner=c(0.1,0.9),lines=T), data=data.plot.mixerror, ylim = c(0.8, 1), main = "Mix error", xlab = "Mix", ylab = "Mean error rate"))

  SEplot <- summarySE(CS_error_mix, measurevar="accuracy", groupvars=c("fgroup", "fblock"))
  SEplot
  names(SEplot)[1] <- "group"
  names(SEplot)[2] <- "block"
  SEplot

  ggplot(SEplot, aes(x=block ,y=accuracy, color = group, group = group)) + ylim(0.8, 1) + geom_errorbar(aes(ymin=accuracy-se, ymax=accuracy+se), width=.1) + geom_line() + geom_point() + theme(panel.background = element_rect(fill = 'white', colour = 'grey')) + ggtitle("Mix error")

