sms_raw<-read.csv("sms_spam_ansi.txt", stringsAsFactors = F)
str(sms_raw)
sms_raw$type<-factor(sms_raw$type)
str(sms_raw)
table(sms_raw$type)
sms_test<-read.csv("ÇÜ½ºÆÔÅ×½ºÆ®.txt", stringsAsFactors = F)
str(sms_test)
sms_test$type<-factor(sms_test$type)
str(sms_test)
table(sms_test$type)

library(tm)
library(SnowballC)
library(wordcloud)
Corpus(VectorSource(sms_raw$text))
Corpus(VectorSource(sms_test$text))
sms_corpus<-VCorpus(VectorSource(sms_raw$text))
sms_corpus
test_corpus<-VCorpus(VectorSource(sms_test$text))
test_corpus
inspect(sms_corpus)
inspect(test_corpus)
class(sms_corpus[[1]])
class(test_corpus[[1]])
as.character(sms_corpus[[1]])
as.character(test_corpus[[1]])
lapply(sms_corpus[1:3], as.character)
lapply(test_corpus[1:3], as.character)
sms_corpus_clean<-tm_map(sms_corpus, removeNumbers)
sms_corpus_clean<-tm_map(sms_corpus_clean, content_transformer(tolower))
sms_corpus_clean<-tm_map(sms_corpus_clean, removePunctuation)
sms_corpus_clean<-tm_map(sms_corpus_clean, removeWords, stopwords())
sms_corpus_clean
sms_corpus_clean<-tm_map(sms_corpus_clean, stemDocument)
sms_corpus_clean<-tm_map(sms_corpus_clean, stripWhitespace)

test_corpus_clean<-tm_map(test_corpus, removeNumbers)
test_corpus_clean<-tm_map(test_corpus_clean, content_transformer(tolower))
test_corpus_clean<-tm_map(test_corpus_clean, removePunctuation)
test_corpus_clean<-tm_map(test_corpus_clean, removeWords, stopwords())
test_corpus_clean
test_corpus_clean<-tm_map(test_corpus_clean, stemDocument)
test_corpus_clean<-tm_map(test_corpus_clean, stripWhitespace)
lapply(sms_corpus[1:3], as.character)
lapply(sms_corpus_clean[1:3], as.character)
lapply(test_corpus[1:3], as.character)
lapply(test_corpus_clean[1:3], as.character)
sms_dtm<-DocumentTermMatrix(sms_corpus_clean)
sms_dtm
test_dtm<-DocumentTermMatrix(test_corpus_clean)
test_dtm

sms_train_labels<-sms_raw[1:5559,]$type
sms_test_labels<-sms_raw[1:10,]$type

sms_dtm_train<-sms_dtm[1:5559,]
sms_dtm_test<-test_dtm[1:10,]

prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))

spam<-subset(sms_raw, type=="spam")
ham<-subset(sms_raw, type=="ham")
library(e1071)

sms_dtm_freq_train<-removeSparseTerms(sms_dtm_train, 0.999)
sms_dtm_freq_train

sms_freq_words<-findFreqTerms(sms_dtm_train, 5)
sms_freq_words<-findFreqTerms(sms_dtm_test, 2)
str(sms_freq_words)
sms_dtm_freq_train<-sms_dtm_train[,sms_freq_words]
sms_dtm_freq_test<-sms_dtm_test[,sms_freq_words]

inspect(sms_dtm_freq_train)
inspect(sms_dtm_freq_test)

convertCounts<-function(x){
  x<-ifelse(x>0, "Yes", "No")
}
sms_train<-apply(sms_dtm_freq_train, MARGIN = 2, convertCounts)
sms_train
sms_test<-apply(sms_dtm_freq_test, MARGIN = 2, convertCounts)
sms_test
smsClassifier<-naiveBayes(sms_train, sms_train_labels, laplace = 1)
smsClassifier
sms_test_pred<-predict(smsClassifier, sms_test)
sms_test_pred
library(gmodels)
CrossTable(sms_test_pred, sms_test_labels, dnn=c("predicted", "actual"))
