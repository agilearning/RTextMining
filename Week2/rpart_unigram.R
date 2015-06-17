
GData <- unlist(GpostDf$Title)
HPData <- unlist(HPpostDf$Title)
AllData <- c(GData, HPData)

regExToken = function(msg, RegExPattern = "[\u4E00-\u9FA5]"){
  matches = gregexpr(RegExPattern,msg)
  paste(unlist(regmatches(msg,matches)),collapse = " ")
}

messages = unlist(AllData)
segRes = lapply(messages,regExToken)


library(tm)
tmWordsVec = unlist(segRes)
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



