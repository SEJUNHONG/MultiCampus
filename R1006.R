library(ggplot2)
library(dplyr)
mpg <- ggplot2::mpg

# Q1
mpg4<-
mpg %>% 
  filter(displ<=4)
mpg4 %>% 
  summarise(displ_under4_hwy=mean(hwy))  # hwy=26.0
mpg5<-
mpg %>% 
  filter(displ>=5)
mpg5 %>% 
  summarise(displ_over5_hwy=mean(hwy))  # hwy=18.1

# Q2
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mc=mean(cty))   # audi 17.6, toyota 18.5

# Q3
mpg_chevrolet<-
  mpg %>% 
  filter(manufacturer=="chevrolet")
mpg_chevrolet %>% 
  summarise(chev_hwy=mean(hwy))    # Chevrolet : 21.9
mpg_ford<-
  mpg %>% 
  filter(manufacturer=="ford")
mpg_ford %>% 
  summarise(ford_hwy=mean(hwy))    # ford : 19.4
mpg_honda<-
  mpg %>% 
  filter(manufacturer=="honda")
mpg_honda %>% 
  summarise(honda_hwy=mean(hwy))   # honda : 32.6

# Q4
new_mpg<-
  mpg %>% 
  select(class, cty)
new_mpg

# Q5
new_mpg %>% 
  group_by(class) %>% 
  summarise(mean(cty))   # suv : 13.5 < compact : 20.1

# Q6
mpg_audi<-
  mpg %>% 
  filter(manufacturer=="audi")
mpg_audi %>% 
  arrange(hwy) %>% 
  tail

# Q7
mpg<-as.data.frame(ggplot2::mpg)
mpg_new<-mpg
mpg_new<-
mpg_new %>% 
  mutate(cty_hwy=cty+hwy)

# Q8
mpg_new<-
mpg_new %>% 
  mutate(mean_cty_hwy=(cty+hwy)/2)
mpg_new

# Q9-1
mpg_new %>% 
  arrange(mean_cty_hwy) %>% 
  tail(3)

# Q9-2
mpg %>% 
  mutate(cty_hwy=cty+hwy,
         mean_cty_hwy=(cty_hwy)/2) %>% 
  arrange(mean_cty_hwy) %>% 
  tail(3)

# Q10
mpg<-
mpg %>% 
  group_by(manufacturer) %>% 
  mutate(mean_cty_hwy=(cty+hwy)/2)
mpg_du<-
mpg %>% 
  arrange(mean_cty_hwy, desc=F)
mpg_du[-which(duplicated(mpg_du$manufacturer)),] %>% 
  head(5)   # dodge < jeep < chevrolet < ford < land rover

# Q11
mpg %>% 
  group_by(class) %>% 
  summarise(cty_mean=mean(cty))

# Q12
mpg %>% 
  group_by(class) %>% 
  summarise(cty_mean=mean(cty)) %>% 
  arrange(desc(cty_mean))

# Q13
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(hwy_mean=mean(hwy)) %>% 
  arrange(desc(hwy_mean)) %>% 
  head(3)

# Q14
mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n))
