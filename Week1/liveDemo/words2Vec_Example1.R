library(jsonlite)
source("fbCommentData.R")

fbCommentData = fromJSON(jsonData)
messages = fbCommentData$data$message

head(messages)
tail(messages)

msg = messages[42]
msg
matches = gregexpr("[\u4E00-\u9FA5]",msg)
unlist(regmatches(msg,matches))
srcWordsDF = data.frame(w=unlist(regmatches(msg,matches)),n=1,stringsAsFactors=FALSE)
temp = aggregate(n~w,srcWordsDF,sum)

as.list(temp)

msg_to_vec = function(msg){
  matches = gregexpr("[\u4E00-\u9FA5]",msg)
  srcWordsDF = data.frame(w=unlist(regmatches(msg,matches)),n=1,stringsAsFactors=FALSE)
  aggregate(n~w,srcWordsDF,sum)
}

lapply(messages,msg_to_vec)
msg_to_vec(messages[11])

msg_to_vec = function(msg){
  matches = gregexpr("[\u4E00-\u9FA5]|[A-Za-z]+",msg)
  srcWordsDF = data.frame(w=unlist(regmatches(msg,matches)),n=1,stringsAsFactors=FALSE)
  sum_df = aggregate(n~w,srcWordsDF,sum)
  df = t(data.frame(sum_df$n,row.names = sum_df$w,stringsAsFactors=FALSE))
  rownames(df) = NULL
  df
}

tmp2 = lapply(messages,msg_to_vec)
rbind(tmp2[[1]],tmp2[[2]])


tmp2 = do.call(cbind,lapply(messages,msg_to_vec))

###############################################

msg = messages[42]
msg
matches = gregexpr("[\u4E00-\u9FA5]",msg)
paste(unlist(regmatches(msg,matches)),collapse=" ")
tmVec = paste(unlist(regmatches(msg,matches)),collapse=" ")

library(tm)
VCorpus(VectorSource(tmVec))
test = Corpus(VectorSource(tmVec))
test[[1]]
undebug(TermDocumentMatrix)

tdm = TermDocumentMatrix(test,control = list(wordLengths = c(1, Inf)))
tdm

VectorSource(tmVec)
Corpus(VectorSource(tmVec))
