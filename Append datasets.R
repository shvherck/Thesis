### Colour-Shape Switch Task ###

setwd("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/CS")

list = list.files(path = "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/CS")


for(i in 1:length(list)){
  name = list[i]
  dataSet = read.table(name, fill = T, header = F, sep = "\t",  na.strings = "")
  numRow = dim(dataSet)[1]
  numRow = as.numeric(numRow)
  if(i == 1){
    dataSet = dataSet[0:numRow,  ]
  }
  else{
    dataSet = dataSet[1:numRow,  ]
  }
  write.table(dataSet, file = "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS.txt", append = TRUE, quote = FALSE, sep = "\t", na = "NA", row.names = FALSE, col.names = FALSE)
}

### Simon Task ###

setwd("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/S")

list = list.files(path = "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/S")


for(i in 1:length(list)){
  name = list[i]
  dataSet = read.table(name, fill = T, header = F, sep = "\t",  na.strings = "")
  numRow = dim(dataSet)[1]
  numRow = as.numeric(numRow)
  if(i == 1){
    dataSet = dataSet[0:numRow,  ]
  }
  else{
    dataSet = dataSet[1:numRow,  ]
  }
  write.table(dataSet, file = "/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_S.txt", append = TRUE, quote = FALSE, sep = "\t", na = "NA", row.names = FALSE, col.names = FALSE)
}