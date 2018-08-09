library(trimr)

### Colour-Shape Switch Task ###

CS = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS.txt", fill = T, header = F, sep = "\t",  na.strings = "")
head(CS)

names(CS) <- c('trial','participant','group','block','switch', 'rt', 'accuracy')
head(CS)

write.table(CS, file = "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS_error.txt", sep = "\t", na = "NA", row.names = FALSE)

CS_data = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS_error.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(CS_data)

CS_data$condition <- paste(CS_data$Block, "_", CS_data$Switch, sep = "")
head(CS_data)

trimmedCS <- sdTrim(data = CS_data, minRT = 0, sd = 2.5, perCondition = FALSE, perParticipant = TRUE, returnType = "raw", digits = 0)
trimmedCS$condition = NULL
trimmedCS

write.table(trimmedCS, file = "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS_RT.txt", sep = "\t", na = "NA", row.names = FALSE)


### Simon Task ###

S = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_S.txt", fill = T, header = F, sep = "\t",  na.strings = "")
head(S)

names(S) <- c('trial','participant','group','congruency','rt','accuracy')
head(S)

write.table(S, file = "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_S_error.txt", sep = "\t", na = "NA", row.names = FALSE)

S_data = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_S_error.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(S_data)
nrow(S_data)

S_data$condition <- paste(S_data$congruency)
head(S_data)

trimmedS <- sdTrim(data = S_data, minRT = 0, sd = 2.5, perCondition = FALSE, perParticipant = TRUE, returnType = "raw", digits = 0)
trimmedS$condition = NULL
trimmedS

write.table(trimmedS, file = "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_S_RT.txt", sep = "\t", na = "NA", row.names = FALSE)

