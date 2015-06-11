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

msg = unlist(postDf$Title)[1]
RegExPattern = "[\u4E00-\u9FA5]"
matches = gregexpr(RegExPattern,msg)
paste(unlist(regmatches(msg,matches)),collapse = " ")

regExToken = function(msg, RegExPattern = "[\u4E00-\u9FA5]"){
  matches = gregexpr(RegExPattern,msg)
  paste(unlist(regmatches(msg,matches)),collapse = " ")
}


messages = unlist(postDf$Title)
segRes = lapply(messages,regExToken)


library(tm)
tmWordsVec = unlist(segRes)
corpus <- Corpus(VectorSource(tmWordsVec))
tdm = TermDocumentMatrix(corpus,control = list(wordLengths = c(1, Inf)))
inspect(tdm)
