insurance<-read.csv("insurance.csv", stringsAsFactors = T)
str(insurance)
summary(insurance$expenses)
hist(insurance$expenses)
table(insurance$sex)
table(insurance$smoker)
table(insurance$region)
cor(insurance[c("age","bmi","children","expenses")])
insurance[c("age","bmi","children","expenses")]
pairs(insurance[c("age","bmi","children","expenses")])
install.packages("psych")
library(psych)
pairs.panels(insurance[c("age","bmi","children","expenses")])
ins_model<-lm(expenses~age+children+bmi+sex+smoker+region, data = insurance)
ins_model
summary(ins_model)
temp<-data.frame(age=25, children=2, bmi=30, sex='female', smoker='yes', region='northeast')
temp
predict(ins_model, newdata = temp)

mydata<-read.csv("ins_model_test.csv", stringsAsFactors = T)
mydata
predict(ins_model, newdata = mydata)
