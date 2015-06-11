library(jsonlite)
source("fbCommentData.R")

fbCommentData = fromJSON(jsonData)
messages = fbCommentData$data$message

head(messages)
tail(messages)

library("Rwordseg", lib.loc="/usr/local/lib/R/site-library")
segmentCN(messages)
segmentCN(messages,returnType = "tm")

library(tm)
tmWordsVec = segmentCN(messages,returnType = "tm")
corpus <- Corpus(VectorSource(tmWordsVec))
tdm = TermDocumentMatrix(corpus)
inspect(tdm)

findFreqTerms(tdm, lowfreq=5)
tf <- rowSums(as.matrix(tdm))

apply(as.matrix(tdm),1,function(vec) NROW(vec[vec>0]))
which(tdm$dimnames$Terms == "中華民國")
inspect(tdm[88,])

idf = 1/apply(as.matrix(tdm),1,function(vec) NROW(vec[vec>0]))

filteredTF =  subset(tf, tf>=3)

barplot(tf)
barplot(filteredTF)

names(tf)
messages
messages[42]
segmentCN(messages[42])
