iris
iris3

y<-rnorm(100)
hist(y)
x<-matrix(rnorm(100),nrow=5)
dist(x, method="manhattan")

data(iris)
head(iris)

kmeans.iris<-kmeans(iris[,5], 3)
kmeans.iris$centers
kmeans.iris$cluster

table(iris[,5], kmeans.iris$cluster)

kmeans10.iris<-kmeans(iris[,-5],3, nstart = 10)
round(sum(kmeans10.iris$withinss),2)
set.seed(123)

kmeans.iris<-kmeans(iris[,-5],3)
round(sum(kmeans.iris$withinss), 2)

library(ggplot2)
iris_plot<-ggplot(data=iris, aes(x=Petal.Length , y=Petal.Width, colour=Species))+
  geom_point(shape=19, size=4)+ggtitle("iris data")
iris_plot2<-iris_plot+
  annotate("text", x=1.5, y=0.7, label="Setosa", size=5)+
  annotate("text", x=3.5, y=1.5, label="Versicolor", size=5)+
  annotate("text", x=6, y=2.7, label="Virginica", size=5)

iris_k_means<-kmeans(iris[,c("Petal.Length", "Petal.Width")], 3)
iris_k_means
iris_k_means$cluster
iris_k_means$totss
iris_k_means$withinss
iris_k_means$betweenss
prop.table(iris_k_means$size)
iris_k_means_centers<-iris_k_means$centers
iris_plot2+annotate("point", x=5.59, y=2.03, size=5, color="black")+
  annotate("point", x=1.46, y=0.24, size=5, color="black")+
  annotate("point", x=4.26, y=1.34, size=5, color="black")

z_iris<-scale(iris[,-5])
