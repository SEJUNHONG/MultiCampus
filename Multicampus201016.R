grocery<-read.csv("groceries.csv")
dim(grocery)

install.packages("arules")
library(arules)
groceries<-read.transactions("groceries.csv", sep=",")
summary(groceries)
inspect(groceries[1:5])
groceries
itemFrequency(groceries[,169])
itemFrequencyPlot(groceries, support=0.1)
itemFrequencyPlot(groceries, topN=20)
image(groceries[1:169])
groceryRules<-apriori(groceries, parameter = list(support=0.1))
groceryRules
groceryRules<-apriori(groceries, parameter = list(support=0.005, confidence=0.25, minlen=2))
summary(groceryRules)
inspect(groceryRules[1:5])
inspect(sort(groceryRules, by="lift")[1:5])
groceryRules

berryRules<-subset(groceryRules, items %in% "berries")
write(berryRules, file="berryrules.csv", sep=",", row.names=F)
berryDf<-as(berryRules, "data.frame")
str(berryDf)
inspect(subset(groceryRules, items %in% c("berries", "yogurt")))
