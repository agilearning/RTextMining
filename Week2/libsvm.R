
install.packages("e1071")
library(e1071)

m = svm(Y~.,data=df,kernel = "linear")
m$kernel
?svm
m$SV
colnames(m$SV)

pred = predict(m,df)
table(pred,df$Y)


w = t(m$SV) %*% m$coefs 
w
