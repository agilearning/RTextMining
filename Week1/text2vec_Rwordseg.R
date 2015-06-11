# library(RPTT)
# listPageUrls = getListPageUrls("Gossiping")[1:5]
# postUrls = unlist(lapply(listPageUrls,getPostUrls))
# postData = lapply(postUrls, function(url) try(getPostData(url),TRUE))
# error_idx = which(sapply(postData, function(x) class(x)) == "try-error")
# data_idx = which(sapply(postData, function(x) class(x)) != "try-error")
# data = postData[data_idx]
# postDf = data.frame(do.call(rbind,lapply(postData[data_idx],function(xx) xx$postData )))
# pushDf = do.call(rbind,lapply(postData[data_idx],function(xx) xx$pushDf))

unlist(postDf$Title)[1]
library(Rwordseg)
segmentCN(unlist(postDf$Title)[1],,returnType = "tm")

library(tm)
messages = unlist(postDf$Title)
tmWordsVec = segmentCN(messages,returnType = "tm")
corpus <- Corpus(VectorSource(tmWordsVec))
tdm = TermDocumentMatrix(corpus,control = list(wordLengths = c(1, Inf)))
inspect(tdm)
