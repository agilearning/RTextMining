

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

distMatrix <- dist(scale(dtm))
fit <- hclust(distMatrix, method="ward")
plot(fit)
rect.hclust(fit, k=10)
(groups <- cutree(fit, k=10))