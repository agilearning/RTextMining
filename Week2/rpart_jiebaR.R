
GData <- unlist(GpostDf$Title)
HPData <- unlist(HPpostDf$Title)
AllData <- c(GData, HPData)


library(jiebaR)
mixseg = worker()

messages = unlist(AllData)

segRes = lapply(messages,function(msg) mixseg <= msg)
paste(segRes[[1]],collapse = " ")


library(tm)
tmWordsVec = sapply(segRes,function(ws) paste(ws,collapse = " "))
corpus <- Corpus(VectorSource(tmWordsVec))
tdm = TermDocumentMatrix(corpus,control = list(wordLengths = c(1, Inf)))
inspect(tdm)


library(rpart)
Features = t(as.matrix(tdm))
Labels = c(rep("G",length(GData)),rep("HP",length(HPData)))


df = data.frame(Y=Labels,Features)
View(df)

model = rpart(Y~.,data=df)

# Y = f(X1,X2,..)
plot(model)
text(model)



model = rpart(Y~.,data=df,minsplit=1, cp=1e-3)

plot(model)
text(model)

model$splits



