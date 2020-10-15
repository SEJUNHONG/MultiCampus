credit<-read.csv("credit.csv")
str(credit)
table(credit$checking_balance)
table(credit$savings_balance)
summary(credit$months_loan_duration)
summary(credit$amount)
table(credit$default)

# 훈련 : 90% 테스트 : 10%
set.seed(123)
trainSample<-sample(1000,900)
str(trainSample)
str(credit)
creditTrain<-credit[trainSample,]
creditTest<-credit[-trainSample,]

table(creditTrain$default)
table(creditTest$default)

# 의사결정트리
install.packages("C50")
library(C50)
str(credit)
creditTrain$default<-factor(creditTrain$default)
str(creditTrain)
creditTrain[-17]
model<-C5.0(creditTrain[-17], creditTrain$default, trials = 50)
model
creditPred<-predict(model, creditTest[-17])
library(gmodels)
CrossTable(creditTest$default, creditPred, dnn=c("actual default", "predict default"))
