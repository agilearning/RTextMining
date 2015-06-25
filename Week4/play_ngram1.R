GData <- unlist(GpostDf$Title)
HPData <- unlist(HPpostDf$Title)
AllData <- c(GData, HPData)

library(dplyr)
test = sapply(AllData, ngram_split, 2, USE.NAMES = FALSE)
filtered_idx = sapply(test,function(xx)dim(xx)[2]>0)
test = test[filtered_idx]
df = data.frame(do.call(rbind,test), stringsAsFactors = FALSE)
names(df)<- c("w1","w2")
wcount = df %>% group_by(w1,w2) %>% summarise(n=n()) 

df = arrange(wcount,desc(n))

wcount$w1 == "計"

df %>% filter(w1=="計")
df %>% filter(w1=="八")

