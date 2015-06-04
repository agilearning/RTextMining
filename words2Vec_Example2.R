
library("Rwordseg", lib.loc="/usr/local/lib/R/site-library")

messages = c("你愛她","她愛你")
segmentCN(messages)
segmentCN(messages,returnType = "tm")

library(tm)
tmWordsVec = segmentCN(messages,returnType = "tm")
corpus <- Corpus(VectorSource(tmWordsVec))
tdm = TermDocumentMatrix(corpus,control = list(removePunctuation = FALSE,
                                               stopwords = FALSE))
as.matrix(tdm)

?TermDocumentMatrix
?Corpus
