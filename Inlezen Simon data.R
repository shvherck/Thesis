S_PP35 = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Experiment data/Simon/Simon_Exp_Subject_35.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(S_PP35)

names(S_PP35) <- c("Weg","Trial", "Colour", "Position","Congruency", "Answer", "RT", "Correct")
head(S_PP35)

S_PP35$Weg = NULL
S_PP35$Colour = NULL
S_PP35$Position = NULL
S_PP35$Answer = NULL
head(S_PP35)

subjectnr = rep(35, times = length(S_PP35$Trial))
group = rep(2, times = length(S_PP35$Trial))
S_PP35$Subject = subjectnr
S_PP35$Group = group
head(S_PP35)

S_PP35 <- S_PP35[c('Trial','Subject','Group','Congruency','RT','Correct')]
head(S_PP35)

write.table(S_PP35, "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/S/S_PP35.txt", sep = "\t", row.names = FALSE, col.names = FALSE)
