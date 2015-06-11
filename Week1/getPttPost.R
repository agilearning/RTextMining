
# library(devtools)
# install_github("agilearning/RPTT")

library(RPTT)
listPageUrls = getListPageUrls("Gossiping")[1:5]
postUrls = unlist(lapply(listPageUrls,getPostUrls))
postData = lapply(postUrls, function(url) try(getPostData(url),TRUE))
error_idx = which(sapply(postData, function(x) class(x)) == "try-error")
data_idx = which(sapply(postData, function(x) class(x)) != "try-error")
data = postData[data_idx]
postDf = data.frame(do.call(rbind,lapply(postData[data_idx],function(xx) xx$postData )))
pushDf = do.call(rbind,lapply(postData[data_idx],function(xx) xx$pushDf))
