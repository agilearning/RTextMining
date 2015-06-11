
library(jiebaR)

mixseg = worker()

messages = c("你愛她","她愛你")
lapply(messages,function(msg) mixseg <= msg)

