kmeans2.iris<-kmeans(iris[,-5],2)

kmeans4.iris<-kmeans(iris[,-5],4)
kmeans2.iris$cluster

kmeans4.iris$cluster
table(iris[,5], kmeans2.iris$cluster)

table(iris[,5], kmeans4.iris$cluster)
library(ggplot2)
iris_plot<-ggplot(data=kmeans2.iris, aes(x=Petal.Length , y=Petal.Width, colour=Species))+
  geom_point(shape=19, size=4)+ggtitle("iris data")
iris_plot

kmeans3.iris<-kmeans(iris[,-5],3)
kmeans3.iris$cluster
table(iris[,5], kmeans3.iris$cluster)
iris_plot<-ggplot(data=kmeans3.iris, aes(x=Petal.Length , y=Petal.Width, colour=Species))+
  geom_point(shape=19, size=4)+ggtitle("iris data")
iris_plot
