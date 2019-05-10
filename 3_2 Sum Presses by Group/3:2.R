#load dataset -tdcs
library(readxl)
tdcs <- read_excel("~/Documents/research/Research/3_2 Add Duplicate Row Values/tdcs.xlsx")

#reshape data 
data <- tdcs[,c(1,2,5,14,4,15:20)]
library(plyr)
sumPresses <- ddply(data, .(pID, issue, direction, stim, didactic, guesscorrect, edu, lad, age, female), function(data) c(button_presses=sum(data$button_presses)))
newDataSet <- sumPresses[order(sumPresses$stim),] #newDataSet is what we want

#export dataset
write.csv(newDataSet, "newDataSet.csv")

