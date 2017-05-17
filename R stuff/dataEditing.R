setwd("~/abel/bigdata/Final project/")
getwd()

library(rpart)
install.packages('rattle')
install.packages('rpart.plot')
install.packages('RColorBrewer')
install.packages("party")
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(readr)
library(party)

library(readr)
newTrain <- read_csv("~/abel/bigdata/Final project")
View(newTrain)



library(readr)
superTrain <- read_csv("~/abel/bigdata/Final project/newTrain.csv", 
                     col_types = cols(X1 = col_skip(), row_id = col_skip()))
View(superTrain)


maxnum <- max(train$time)

numPlace <- count(dist(train$place_id))


newTrain <- data.frame(train[train$accuracy < 200,])

write.csv(newTrain, "newTrain2.csv", row.names=FALSE, col.names = FALSE)

write.table(newTrain,"newTrain3.csv", col.names=FALSE, sep=",")
