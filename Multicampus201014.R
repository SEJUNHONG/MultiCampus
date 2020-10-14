sms_raw<-read.csv("sms_spam_ansi.txt", stringsAsFactors = F)
str(sms_raw)
sms_raw$type<-factor(sms_raw$type)
str(sms_raw)
table(sms_raw$type)
install.packages("tm") # 텍스트 마이닝 툴
library(tm)
stopwords("en")
removeWords("of the people", stopwords("en"))
IMDB<-read.csv("IMDB-Movie-Data.csv")
str(IMDB)
summary(IMDB)
sum(is.na(IMDB$Metascore))
colSums(is.na(IMDB))
IMDB2<-na.omit(IMDB)
colSums(is.na(IMDB2))
IMDB3<-IMDB[complete.cases((IMDB[,12])),]
colSums(is.na(IMDB3))

IMDB$Metascore2<-IMDB$Metascore
IMDB$Metascore2[is.na(IMDB$Metascore2)]<-50
IMDB$Metascore2
mean(IMDB$Revenue..Millions., na.rm=T)
Q1<-quantile(IMDB$Revenue..Millions., probs=c(0.25), na.rm = T)
Q3<-quantile(IMDB$Revenue..Millions., probs=c(0.75), na.rm = T)
LC<-Q1-1.5*(Q3-Q1)
UC<-Q3+1.5*(Q3-Q1)
IMDB2<-subset(IMDB, IMDB$Revenue..Millions.>LC & IMDB$Revenue..Millions.<UC)
IMDB2
IMDB$Actors[1]
substr(IMDB$Actors[1], 1, 5)
paste(IMDB$Actors[1],"_", "A", sep="")
strsplit(IMDB$Actors[1], split=",")
IMDB$Genre2<-gsub(",", " ", IMDB$Genre)
IMDB$Genre2

CORPUS<-Corpus(VectorSource(IMDB$Genre2))
CORPUS_TM=tm_map(CORPUS, removePunctuation)
CORPUS_TM<-tm_map(CORPUS_TM, removeNumbers)
CORPUS_TM<-tm_map(CORPUS_TM, tolower)
DTM<-DocumentTermMatrix(CORPUS_TM)
DTM
inspect(DTM)

IMDB$Genre2[1]
DTM<-as.data.frame(as.matrix(DTM))
head(DTM)
IMDB_GENRE<-cbind(IMDB, DTM)
IMDB_GENRE

IMDB$Description
CORPUS<-Corpus(VectorSource(IMDB$Description))
CORPUS_TM<-tm_map(CORPUS, stripWhitespace)
CORPUS_TM<-tm_map(CORPUS_TM, removeNumbers)
CORPUS_TM<-tm_map(CORPUS_TM, tolower)
CORPUS_TM<-tm_map(CORPUS_TM, removePunctuation)
DTM<-DocumentTermMatrix(CORPUS_TM)
inspect(DTM)
IMDB$Description[155]
CORPUS_TM<-tm_map(CORPUS_TM, removeWords, c(stopwords("english"), "my", "custom", "words"))
TDM<-TermDocumentMatrix(CORPUS_TM)
m<-as.matrix(TDM)
m
rowSums(m)
v<-sort(rowSums(m), decreasing = T)
names(v)
d<-data.frame(word=names(v), freq=v)
install.packages("SnowballC")
library(SnowballC)
install.packages("wordcloud")
library(wordcloud)
install.packages("RColorBrewer")
library(RColorBrewer)

wordcloud(words=d$word, freq=d$freq, min.freq=5, max.words=200, random.order=F,
          colors=brewer.pal(8, "Dark2"))

Corpus(VectorSource(sms_raw$text))
sms_corpus<-VCorpus(VectorSource(sms_raw$text))
sms_corpus
inspect(sms_corpus)
class(sms_corpus[[1]])
as.character(sms_corpus[[1]])
lapply(sms_corpus[1:3], as.character)
sms_corpus_clean<-tm_map(sms_corpus, removeNumbers)
sms_corpus_clean<-tm_map(sms_corpus_clean, content_transformer(tolower))
sms_corpus_clean<-tm_map(sms_corpus_clean, removePunctuation)
sms_corpus_clean<-tm_map(sms_corpus_clean, removeWords, stopwords())

removePunctuation("hello...., ; : hihihi")
myReplace<-function(x){
  gsub("[[:punct:]]+", " ", x)
}
myReplace("hello......world")
wordStem(c("learn", "learned","learning","learns"))
sms_corpus_clean<-tm_map(sms_corpus_clean, stemDocument)
sms_corpus_clean<-tm_map(sms_corpus_clean, stripWhitespace)
lapply(sms_corpus[1:3], as.character)
lapply(sms_corpus_clean[1:3], as.character)

sms_dtm<-DocumentTermMatrix(sms_corpus_clean)
sms_dtm


sms_train_labels<-sms_raw[1:4169,]$type
sms_tests_labels<-sms_raw[4170:5559,]$type
sms_dtm_train<-sms_dtm[1:4169,]
sms_dtm_test<-sms_dtm[4170:5559,]
prop.table(table(sms_train_labels))
prop.table(table(sms_tests_labels))

wordcloud(sms_corpus_clean, min.freq = 50, random.order = F)
spam<-subset(sms_raw, type=="spam")
ham<-subset(sms_raw, type=="ham")

wordcloud(spam$text, max.words = 50, random.order = F)
wordcloud(ham$text, max.words = 50, random.order = F)

install.packages("e1071")
library(e1071)

sms_dtm_train
sms_dtm_freq_train<-removeSparseTerms(sms_dtm_train, 0.98)
sms_dtm_freq_train

sms_freq_words<-findFreqTerms(sms_dtm_train, 5)
str(sms_freq_words)
sms_dtm_freq_train<-sms_dtm_train[,sms_freq_words]
sms_dtm_freq_test<-sms_dtm_test[,sms_freq_words]

inspect(sms_dtm_freq_train)
inspect(sms_dtm_freq_test)

convertCounts<-function(x){
  x<-ifelse(x>0, "Yes", "No")
}

sms_train<-apply(sms_dtm_freq_train, MARGIN = 2, convertCounts)
# MARGIN=1 : 행, MARGIN=2 : 열
sms_train
sms_test<-apply(sms_dtm_freq_test, MARGIN = 2, convertCounts)
sms_test
sms_train[1,]
smsClassifier<-naiveBayes(sms_train, sms_train_labels, laplace = 1)
smsClassifier
sms_test_pred<-predict(smsClassifier, sms_test)
sms_test_pred
install.packages("gmodels")
library(gmodels)
CrossTable(sms_test_pred, sms_tests_labels, dnn=c("predicted", "actual"))
