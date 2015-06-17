

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
set.seed(122)
k <- 20
kmeansResult <- kmeans(dtm, k)
round(kmeansResult$centers, digits=3)

for (i in 1:k) {
  cat(paste("cluster ", i, ": ", sep=""))
  s <- sort(kmeansResult$centers[i,], decreasing=T)
  cat(names(s)[1:20], "\n")
}


