

GData <- unlist(GpostDf$Text)
HPData <- unlist(HPpostDf$Text)
AllData <- c(GData, HPData)


library(jiebaR)
mixseg = worker()

messages = unlist(allData)

segRes = lapply(messages,function(msg) mixseg <= msg)
paste(segRes[[1]],collapse = " ")


library(tm)
tmWordsVec = sapply(segRes,function(ws) paste(ws,collapse = " "))
corpus <- Corpus(VectorSource(tmWordsVec))
tdm = TermDocumentMatrix(corpus,control = list(wordLengths = c(1, Inf)))
inspect(tdm)

dtm <- t(as.matrix(tdm))

# install.packages("kernlab")

library(kernlab)
k = 70
sc <- specc(dtm, centers=k)

for (i in 1:k) {
  cat(paste("cluster ", i, ": ", sep=""))
  s <- colnames(dtm)[order(sc@centers[i,]) > 0]
  cat(s, "\n")
}

