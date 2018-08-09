####### Simon effect #######

S = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_S_RT.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(S)
# afhankelijk van kijken naar RT/error andere dataset inlezen
# deze is om te kijken naar RT

for (i in 1:36){

  SP <- subset(S, participant == i)
  print( i)
  print(head(SP))

  SP_congr <- subset(SP, congruency == 1)
  SP_congr_RT <- SP_congr$rt
  print('mean + sd RT congruent')
  print(mean(SP_congr_RT))
  SP_congr_error <- SP_congr$accuracy
  print('mean + sd error congruent')
  print(mean(SP_congr_error))
  
  SP_incongr <- subset(SP, congruency == 0)
  SP_incongr_RT <- SP_incongr$rt
  print('mean + sd RT incongruent')
  print(mean(SP_incongr_RT))
  SP_incongr_error <- SP_incongr$accuracy
  print('mean + sd error incongruent')
  print(mean(SP_incongr_error))
  
  print('Simon effect RT')
  print(mean(SP_incongr_RT) - mean(SP_congr_RT))
  print('Simon effect error')
  print(mean(SP_congr_error) - mean(SP_incongr_error))
  
}

# overall Simon #
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

# Simon RT bi
congr_RT_bi <- D_bi$Simon_congr_RT
mean(na.omit(congr_RT_bi))
sd(na.omit(congr_RT_bi))
incongr_RT_bi <- D_bi$Simon_incongr_RT
mean(na.omit(incongr_RT_bi))
sd(na.omit(incongr_RT_bi))
S_effect_RT_bi <- D_bi$Simon_effect_RT
mean(na.omit(S_effect_RT_bi))
sd(na.omit(S_effect_RT_bi))

# Simon error bi
congr_error_bi <- D_bi$Simon_congr_error
mean(na.omit(congr_error_bi))
sd(na.omit(congr_error_bi))
incongr_error_bi <- D_bi$Simon_incongr_error
mean(na.omit(incongr_error_bi))
sd(na.omit(incongr_error_bi))
S_effect_error_bi <- D_bi$Simon_effect_error
mean(na.omit(S_effect_error_bi))
sd(na.omit(S_effect_error_bi))


# Simon RT mono
congr_RT_mono <- D_mono$Simon_congr_RT
mean(na.omit(congr_RT_mono))
sd(na.omit(congr_RT_mono))
incongr_RT_mono <- D_mono$Simon_incongr_RT
mean(na.omit(incongr_RT_mono))
sd(na.omit(incongr_RT_mono))
S_effect_RT_mono <- D_mono$Simon_effect_RT
mean(na.omit(S_effect_RT_mono))
sd(na.omit(S_effect_RT_mono))

# Simon error mono
congr_error_mono <- D_mono$Simon_congr_error
mean(na.omit(congr_error_mono))
sd(na.omit(congr_error_mono))
incongr_error_mono <- D_mono$Simon_incongr_error
mean(na.omit(incongr_error_mono))
sd(na.omit(incongr_error_mono))
S_effect_error_mono <- D_mono$Simon_effect_error
mean(na.omit(S_effect_error_mono))
sd(na.omit(S_effect_error_mono))


####### Switch cost #######

CS = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS_RT.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(CS)
# deze dataset is om RT te berekenen, voor error is de andere nodig

CS_switch <- subset(CS, block == 1)
head(CS_switch)

for (i in 1:36){
  
  CSP <- subset(CS_switch, participant == i)
  print( i)
  print(head(CSP))
  
  CSP_switch <- subset(CSP, switch == 1)
  CSP_switch_RT <- CSP_switch$rt
  print('mean RT switch')
  print(mean(CSP_switch_RT))
  CSP_switch_error <- CSP_switch$accuracy
  print('mean error switch')
  print(mean(CSP_switch_error))
  
  CSP_nonswitch <- subset(CSP, switch == 0)
  CSP_nonswitch_RT <- CSP_nonswitch$rt
  print('mean RT nonswitch')
  print(mean(CSP_nonswitch_RT))
  CSP_nonswitch_error <- CSP_nonswitch$accuracy
  print('mean error nonswitch')
  print(mean(CSP_nonswitch_error))
  
  print('Switch cost RT')
  print(mean(CSP_switch_RT) - mean(CSP_nonswitch_RT))
  print('Switch cost error')
  print(mean(CSP_nonswitch_error) - mean(CSP_switch_error))
  
}


# overall switch #
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

# Switch RT bi
switch_RT_bi <- D_bi$Switch_RT
mean(na.omit(switch_RT_bi))
sd(na.omit(switch_RT_bi))
nonswitch_RT_bi <- D_bi$Nonswitch_RT
mean(na.omit(nonswitch_RT_bi))
sd(na.omit(nonswitch_RT_bi))
switch_cost_RT_bi <- D_bi$Switch_cost_RT
mean(na.omit(switch_cost_RT_bi))
sd(na.omit(switch_cost_RT_bi))

# Simon error bi
switch_error_bi <- D_bi$Switch_error
mean(na.omit(switch_error_bi))
sd(na.omit(switch_error_bi))
nonswitch_error_bi <- D_bi$Nonswitch_error
mean(na.omit(nonswitch_error_bi))
sd(na.omit(nonswitch_error_bi))
switch_cost_error_bi <- D_bi$Switch_cost_error
switch_cost_error_bi
mean(na.omit(switch_cost_error_bi))
sd(na.omit(switch_cost_error_bi))


# Switch RT mono
switch_RT_mono <- D_mono$Switch_RT
mean(na.omit(switch_RT_mono))
sd(na.omit(switch_RT_mono))
nonswitch_RT_mono <- D_mono$Nonswitch_RT
mean(na.omit(nonswitch_RT_mono))
sd(na.omit(nonswitch_RT_mono))
switch_cost_RT_mono <- D_mono$Switch_cost_RT
mean(na.omit(switch_cost_RT_mono))
sd(na.omit(switch_cost_RT_mono))

# Simon error bi
switch_error_mono <- D_mono$Switch_error
mean(na.omit(switch_error_mono))
sd(na.omit(switch_error_mono))
nonswitch_error_mono <- D_mono$Nonswitch_error
mean(na.omit(nonswitch_error_mono))
sd(na.omit(nonswitch_error_mono))
switch_cost_error_mono <- D_mono$Switch_cost_error
switch_cost_error_mono
mean(na.omit(switch_cost_error_mono))
sd(na.omit(switch_cost_error_mono))


####### Mix cost #######

CS = read.table("/Users/Shauni/Desktop/2e master 2017 - 2018/Masterproef II/3. Data/Data_CS_RT.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(CS)
# deze dataset is om RT te berekenen, voor error is de andere nodig

CS_mix <- subset(CS, switch == 0)
head(CS_mix)

for (i in 1:36){
  
  CSP <- subset(CS_mix, participant == i)
  print( i)
  print(head(CSP))
  
  CSP_mixed <- subset(CSP, block == 1)
  CSP_mixed_RT <- CSP_mixed$rt
  print('mean RT mixed')
  print(mean(CSP_mixed_RT))
  CSP_mixed_error <- CSP_mixed$accuracy
  print('mean error mixed')
  print(mean(CSP_mixed_error))
  
  CSP_single <- subset(CSP, block == 0)
  CSP_single_RT <- CSP_single$rt
  print('mean RT single')
  print(mean(CSP_single_RT))
  CSP_single_error <- CSP_single$accuracy
  print('mean error single')
  print(mean(CSP_single_error))
  
  print('Mix cost RT')
  print(mean(CSP_mixed_RT) - mean(CSP_single_RT))
  print('Mix cost error')
  print(mean(CSP_single_error) - mean(CSP_mixed_error))
  
}

# overall mix #
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

# Mix RT bi
mixed_RT_bi <- D_bi$Mixed_RT
mean(na.omit(mixed_RT_bi))
sd(na.omit(mixed_RT_bi))
single_RT_bi <- D_bi$Single_RT
mean(na.omit(single_RT_bi))
sd(na.omit(single_RT_bi))
mix_cost_RT_bi <- D_bi$Mix_cost_RT
mean(na.omit(mix_cost_RT_bi))
sd(na.omit(mix_cost_RT_bi))

# Mix error bi
mixed_error_bi <- D_bi$Mixed_error
mixed_error_bi
mean(na.omit(mixed_error_bi))
sd(na.omit(mixed_error_bi))
single_error_bi <- D_bi$Single_error
single_error_bi
mean(na.omit(single_error_bi))
sd(na.omit(single_error_bi))
mix_cost_error_bi <- D_bi$Mix_cost_error
mix_cost_error_bi
mean(na.omit(mix_cost_error_bi))
sd(na.omit(mix_cost_error_bi))


# Mix RT mono
mixed_RT_mono <- D_mono$Mixed_RT
mean(na.omit(mixed_RT_mono))
sd(na.omit(mixed_RT_mono))
single_RT_mono <- D_mono$Single_RT
mean(na.omit(single_RT_mono))
sd(na.omit(single_RT_mono))
mix_cost_RT_mono <- D_mono$Mix_cost_RT
mean(na.omit(mix_cost_RT_mono))
sd(na.omit(mix_cost_RT_mono))

# Mix error bi
mixed_error_mono <- D_mono$Mixed_error
mixed_error_mono
mean(na.omit(mixed_error_mono))
sd(na.omit(mixed_error_mono))
single_error_mono <- D_mono$Single_error
single_error_mono
mean(na.omit(single_error_mono))
sd(na.omit(single_error_mono))
mix_cost_error_mono <- D_mono$Mix_cost_error
mix_cost_error_mono
mean(na.omit(mix_cost_error_mono))
sd(na.omit(mix_cost_error_mono))