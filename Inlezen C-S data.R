CS_PP35 = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Experiment data/C-S/ColourShapeSwitch_Exp_Subject_35.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(CS_PP35)

names(CS_PP35) <- c("Trial","Block", "Switch","Task", "Shape", "Colour", "Answer", "RT", "Correct")
head(CS_PP35)

CS_PP35$Task = NULL
CS_PP35$Shape = NULL
CS_PP35$Colour = NULL
CS_PP35$Answer = NULL
head(CS_PP35)

subjectnr = rep(35, times = length(CS_PP35$Block))
group = rep(2, times = length(CS_PP35$Block))
CS_PP35$Subject = subjectnr
CS_PP35$Group = group
CS_PP35$Trial = CS_PP35$Trial + 1
head(CS_PP35)

CS_PP35 <- CS_PP35[c('Trial','Subject','Group','Block','Switch', 'RT', 'Correct')]
head(CS_PP35)

write.table(CS_PP35, "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/CS/CS_PP35.txt", sep = "\t", row.names = FALSE, col.names = FALSE)
