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
srcWordsDF = data.frame(w=unlist(regmatches(msg,matches)),n=1)
aggregate(n~w,srcWordsDF,sum)

msg_to_vec = function(msg){
  matches = gregexpr("[\u4E00-\u9FA5]",msg)
  srcWordsDF = data.frame(w=unlist(regmatches(msg,matches)),n=1)
  aggregate(n~w,srcWordsDF,sum)
}

lapply(messages,msg_to_vec)
msg_to_vec(messages[11])

msg_to_vec = function(msg){
  matches = gregexpr("[\u4E00-\u9FA5]|[A-Za-z]+",msg)
  srcWordsDF = data.frame(w=unlist(regmatches(msg,matches)),n=1)
  sum_df = aggregate(n~w,srcWordsDF,sum)
  df = t(data.frame(sum_df$n,row.names = sum_df$w))
  rownames(df) = NULL
  df
}

lapply(messages,msg_to_vec)

###############################################

msg = messages[42]
msg
matches = gregexpr("[\u4E00-\u9FA5]",msg)
paste(unlist(regmatches(msg,matches)),collapse=" ")
tmVec = paste(unlist(regmatches(msg,matches)),collapse=" ")
TermDocumentMatrix(Corpus(VectorSource(tmVec)))
VectorSource(tmVec)
Corpus(VectorSource(tmVec))
