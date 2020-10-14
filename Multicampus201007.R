library(dplyr)
df <- data.frame(gender=c("m","f",NA,"m","f"), score=c(5,4,3,4,NA))
df
is.na(df)
table(is.na(df))
table(is.na(df$gender))
sum(df$score)
df %>% filter(is.na(score))
dfnew<-df %>% 
  filter(!is.na(score))
mean(dfnew$score)
df %>% filter(!is.na(score) & !is.na(gender))
na.omit(df)
mean(df$score, na.rm=T)
exam<-read.csv("Data/csv_exam.csv")
exam[c(3,8,15),"math"]<-NA
exam
exam %>% 
  summarise(meanm=mean(math, na.rm=T))
ifelse(is.na(exam$math), mean(exam$math, na.rm=T), exam$math)

ol<-data.frame(gen=c(1,2,1,2,3),
               score=c(5,4,1,3,4))
ol
table(ol$gen)
ol$gen<-ifelse(ol$gen==3, NA, ol$gen)
ol
ol %>% 
  filter(!is.na(gen) & !is.na(score)) %>% 
  group_by(gen) %>% 
  summarise(ms=mean(score))
library(ggplot2)
mpg<-ggplot2::mpg
boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats

mpg$hwy<-ifelse(mpg$hwy<12 | mpg$hwy>37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mh=mean(hwy, na.rm=T))

install.packages("foreign")
library(foreign)
library(readxl)
library(ggplot2)
raw_welfare<-read.spss(file="Data/Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
welfare<-raw_welfare
head(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)
welfare<-rename(welfare, 
       sex=h10_g3,
       birth=h10_g4,
       marriage=h10_g10,
       religion=h10_g11,
       income=p1002_8aq1,
       code_job=h10_eco9,
       cide_region=h10_reg7)

table(welfare$sex)
table(is.na(welfare$sex))
welfare$sex <- ifelse(welfare$sex==1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)
summary(welfare$income)
qplot(welfare$income)
qplot(welfare$income)+xlim(0,100)
welfare$income<-ifelse(welfare$income %in% c(0,5000), NA, welfare$income)
table(is.na(welfare$income))
sex_income<-welfare %>% 
  group_by(sex) %>% 
  summarise(mean_income=mean(income, na.rm = T))
sex_income
ggplot(data=sex_income, aes(x=sex, y=mean_income))+geom_col()

welfare$birth
summary(welfare$birth)
qplot(welfare$birth)

table(is.na(welfare$birth))
welfare$birth<-ifelse(welfare$birth==999, NA, welfare$birth)
table(is.na(welfare$birth))

welfare %>% 
  mutate(welfare$age=2015-welfare$birth-1) %>%
  summary(welfare$age)
welfare$age<-2015-welfare$birth+1
summary(welfare$age)
qplot(welfare$age)

age_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income=mean(income))

ggplot(data=age_income, aes(x=age, y=mean_income))+geom_col()
ggplot(data=age_income, aes(x=age, y=mean_income))+geom_line()

welfare<-welfare %>% 
  mutate(ageg=ifelse(age<30,"young",
         ifelse(age<=59, "middle", "old")))
welfare$ageg
table(welfare$ageg)
qplot(welfare$ageg)
sex_income<-welfare %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income=mean(income, na.rm = T))
ggplot(data=ageg_income, aes(x=ageg, y=mean_income))+geom_col()
ggplot(data=sex_income, aes(x=ageg, y=mean_income, fill=sex))+geom_col(position = "dodge")+scale_x_discrete(limits=c("young", "middle", "old"))

welfare$code_job
table(welfare$code_job)
library(readxl)
list_job<-read_excel("Data/Koweps_Codebook.xlsx", col_names = T, sheet=2)
list_job
dim(list_job)

welfare$code_job
welfare<-left_join(welfare, list_job, id="code_job")
str(welfare)
welfare %>% filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

job_income<-welfare %>% 
  group_by(job) %>% 
  summarise(mean_income=mean(income, na.rm = T))
top20<-job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(20)
top20
ggplot(data=top20, aes(x=job, y=mean_income))+geom_col()+coord_flip()

welfare %>% 
  filter(sex=="male") %>% 
  filter(!is.na(job)) %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

table(welfare$religion)
welfare$religion<-ifelse(welfare$religion==1, "yes", "no")
table(welfare$religion)
qplot(welfare$religion)

welfare$marriage
table(welfare$marriage)
welfare$group_marriage<-ifelse(welfare$marriage==1, "marriage", 
                               ifelse(welfare$marriage==3, "divorce", NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

religion_marriage<-welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(cnt=n()) %>% 
  mutate(tot_group=sum(cnt)) %>% 
  mutate(pct=round(cnt/tot_group*100,1))

religion_marriage %>% 
  filter(group_marriage=="divorce") %>% 
  select(religion, pct)
