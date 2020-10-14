#eps(epsilon)
#kmeans를 이용한 clustering(sns data)
library(readxl)
teens<-read.csv("snsdata.csv")
str(teens)
table(teens$gender)
table(teens$gender, useNA="ifany")
table(teens$gradyear)
summary(teens$age)

teens$age<-ifelse(teens$age>=13 & teens$age<20, teens$age, NA)
summary(teens$age)
teens$female<-ifelse(teens$gender=="F" & !is.na(teens$gender), 1, 0)
teens$no_gender<-ifelse(is.na(teens$gender), 1, 0)
table(teens$no_gender)
table(teens$female)
mean(teens$age, na.rm=T)
teens
library(dplyr)
teens %>%
  group_by(gradyear) %>% 
  summarise(mean_age=mean(age, na.rm = T))

aggregate(data=teens, age~gradyear, mean, na.rm=T)
         
x<-1:10
x
mean(x)
ave(x)
mygroup<-rep(1:2, c(3, 7))
ave(x, mygroup, FUN=mean)
ave(x, mygroup, FUN=sum)
ave(x, mygroup, FUN=function(a)sum(a^2))
ave_age<-ave(teens$age, teens$gradyear, FUN = function(x) mean(x, na.rm = T))


teens$age<-ifelse(is.na(teens$age), ave_age, teens$age)
summary(teens$age)
class(teens[5:40])
interests<-teens[5:40]
interests_z<-as.data.frame(lapply(interests, scale)) # 표준화(mu=0, sigma=1)
set.seed(12345)
teen_clusters<-kmeans(interests_z, 5)
teen_clusters
teen_clusters$size
teen_clusters$centers

teens$cluster<-teen_clusters$cluster
teens[1:10, c("cluster", "gender","age","friends")]
aggregate(data=teens, age~cluster, mean)
aggregate(data=teens, friends~cluster, mean)

data<-as.data.frame(snsdata)
data_z<-scale(data)

dist
cosine_sim

install.packages("proxy")
library(proxy)
d1<-c(1,0,5)
d2<-c(4, 7,3)
d3<-c(40,70,30)
doc<-rbind(d1, d2, d3)
colnames(doc)<-c("sky","colud","rain")
doc
dist(doc, method="cosine")
dist(doc, method = "euclidean")
