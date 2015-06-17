##############################
## Sample: 14.jpg
##############################

rm(list=ls(all=TRUE))
library(biOps)

x <- readJpeg("1234_2.jpg")
x <- readJpeg("small_1234.jpg")
x <- readJpeg("1234.jpg")

x <- readJpeg("14.jpg")
grey_x <- imgRGB2Grey(x)

test <- unclass(grey_x)
test_dim <- dim(test)
ncolumns <- test_dim[1]

data_index <- which(test<250)

data_x1 <- data_index%/%ncolumns
data_x2 <- data_index%%ncolumns

data_x2 <- 145 - data_x2
data1234 <- as.data.frame(data_x1)
data1234 <- cbind(data1234,data_x2)
plot(data1234)

##############################
## Sample: 14.jpg [K-means]
##############################

cl <- kmeans(data1234, 4)
plot(data1234, col = cl$cluster)
points(cl$centers, col = 1:4, pch = 8, cex=2)

cl <- kmeans(data1234, 2)
plot(data1234, col = cl$cluster)
points(cl$centers, col = 1:2, pch = 8, cex=2)

##############################
## Sample: 14.jpg [Spectral Clustering]
##############################

library(kernlab)
#sc <- specc(as.matrix(data1234), centers=4)
#save(sc,file="spectral_clustering_1234_3.RData")
#load(file="spectral_clustering_1234_2.RData")
#plot(data1234, col=sc)

sc <- specc(as.matrix(data1234), centers=2)
plot(data1234, col=sc)