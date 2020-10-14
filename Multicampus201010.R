member<-data.frame(spent=c(10,1,1,17,4,6,1,15,22,3,0,3,7,0,2),
           time=c(15,2,10,7,5,7,1,10,18,3,1,3,7,10,2))
member
res<-kmeans(member, 3)
res
install.packages("fpc")
library(fpc)
plotcluster(member, res$cluster, color=T)
res$cluster
res$centers
res$totss
res$withinss
res$tot.withinss
res$betweenss
res$size
res$iter

member$cluster<-res$cluster
member

aggregate(data=member, spent ~ cluster, max)

install.packages("NbClust")
library(NbClust)
NbClust(data, min.nc=2, max.nc = 5, method='kmeans')
nb<-NbClust(iris[,1:4], min.nc=2, max.nc = 5, method='kmeans')
nb$Best.partition
data(iris)
irisscale<-scale(iris[,-5])
k.max=10
wss<-rep(NA, k.max)
nClust<-list()
for (i in 1:k.max){
  irisRes=kmeans(irisscale, i)
  wss[i]=irisRes$tot.withinss
  nClust[[i]]=irisRes$size
  res$tot.withinss
}
wss
nClust
plot(1:k.max, wss, type='b')
fitK<-kmeans(irisscale, 3)
str(fitK)
plot(iris, col=fitK$cluster)
table(predicted=fitK$cluster, Actual=iris$Species)

a<-matrix(rnorm(100), nrow=5)
dist(a)
plot(h<-hclust(dist(a), method="single"))
plot(h<-hclust(dist(a), method="complete"))
plot(h<-hclust(dist(a), method="average"))
plot(h<-hclust(dist(a), method="centroid"))

wbcd<-read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)
str(wbcd)
wbcd<-wbcd[-1]
wbcd$diagnosis<-factor(wbcd$diagnosis, levels=c("B","M"),
                       labels=c("Benign", "Malignant"))
str(wbcd)
wbcd$diagnosis
table(wbcd$diagnosis)
round(prop.table(table(wbcd$diagnosis))*100,1)
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

normalize<-function(x){
  return ((x-min(x))/(max(x)-min(x)))
}

#정규화
normalize(c(1,2,3,4,5))
wbcd_n<-as.data.frame(lapply(wbcd[2:31], normalize))
wbcd_n
wbcd_train<-wbcd_n[1:469,]
wbcd_test<-wbcd_n[470:569,]
wbcd_train_labels<-wbcd[1:469, 1]
wbcd_test_labels<-wbcd[470:569, 1]

library(class)
wbcd_test_pred<-knn(train=wbcd_train, test=wbcd_test, cl=wbcd_train_labels, k=21)
wbcd_test_pred
install.packages("gmodels")
library(gmodels)
CrossTable(x=wbcd_test_labels, y=wbcd_test_pred)

#표준화
wbcd_z<-as.data.frame(scale(wbcd[-1]))
wbcd_train<-wbcd_z[1:469,]
wbcd_test<-wbcd_z[470:569,]
wbcd_train_labels<-wbcd[1:469, 1]
wbcd_test_labels<-wbcd[470:569, 1]
wbcd_test_pred<-knn(train=wbcd_train, test=wbcd_test, cl=wbcd_train_labels, k=21)
wbcd_test_pred
CrossTable(x=wbcd_test_labels, y=wbcd_test_pred)
