print('hello')
install.packages("readxl")
library(readxl)

eng <- c(50,60,70)
mat <- c(70,80,90)

df <- data.frame(eng, mat)
df

class <- c(1,1,2)
dfm <- data.frame(eng,mat,class)
dfm

mean(dfm$eng) #데이터프레임$컬럼명

read_excel("Data/excel_exam.xlsx")
read_excel("Data/excel_exam_novar.xlsx", col_names=F)
read_excel("Data/excel_exam_sheet.xlsx", sheet=3)

data <- read.csv("Data/csv_exam.csv")
str(data)

write.csv(data, file="savefile.csv")

exam <- read.csv("Data/csv_exam.csv")
head(exam)
tail(exam)
View(exam)
dim(exam)
summary(exam)

install.packages("dplyr")
library(dplyr)
reexam <- rename(exam, eng=english)
reexam
reexam$plus_me<-reexam$math+reexam$eng
reexam

reexam$result <- ifelse(reexam$math>=70, "pass", "fail") # np.where
reexam

library(ggplot2)
qplot(reexam$result)

reexam$hakjum <- ifelse(reexam$math<50, "C", 
                        ifelse(reexam$math<=80, "B", "A"))
reexam
table(reexam$hakjum) # value_counts
exam <- read.csv("Data/csv_exam.csv")
exam %>% filter(class==1) # ctrl+shift+m
exam %>% filter(math>=70)
exam %>% filter(math>=70 & english>=70)
exam %>% filter(math>=70|english>=70)
exam %>% filter(class==1|class==3|class==5)
exam %>% filter(class %in% c(1,3,5))
exam %>% select(math)
exam %>% select(math, class)
exam %>% select(-math)
exam %>% select(-math, -class)
exam %>% 
  filter(class==1) %>% 
  select(english)
exam %>% 
  select(id, math) %>% 
  head
exam %>% 
  arrange(math)
exam %>% 
  arrange(desc(math))
exam %>% 
  arrange(class, math)
exam %>% 
  mutate(total=math+english+science,
         mean=total/3) %>% 
  head
exam %>% 
  mutate(res=ifelse(science>=60, "pass","fail")) %>% 
  head
exam %>% 
  summarise(mean_math=mean(math))
exam %>% 
  group_by(class)
exam %>% 
  group_by(class) %>% 
  summarise(mean_math=mean(math),
            sum_math=sum(math),
            median_math=median(math),
            n=n())
ggplot2::mpg
mpg<=as.data.frame(ggplot2::mpg)
str(mpg)
mpga<-mpg %>% 
  filter(displ>5)
mean(mpga$hwy)
a<-data.frame(id=c(1,2),
              test=c(50,90))
b<-data.frame(id=c(3,4),
              test=c(30,100))
a
bind_rows(a,b)
exam
name<-data.frame(class=c(1,2,3,4,5),
                 tea=c("kim","park","lee","cho","jung"))
name
left_join(exam, name, by='class')
