
install.packages("spls")
library(spls)
f <- splsda( as.matrix(df[,-1]), as.matrix(df[,1]), K=10, eta=0.8, scale.x=FALSE )
f
