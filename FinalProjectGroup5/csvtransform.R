# Modify airports, carriers, and plane data
inputfiles <- c("airports.csv", "carriers.csv", "plane-data.csv")
outputfiles <- sapply(strsplit(inputfiles, "[.]"),
                      function(x) paste(x[1],"_mod.",x[2],sep=""))
for(i in 1:length(inputfiles)){
  data<-read.csv(inputfiles[i], header=TRUE)
  for(col in colnames(data)){
    # replace "," with "/," to be able to process csv file in hive
    # using escape character "/"
    data[,col]<-gsub(",", "/,", data[,col])
  }
  write.csv(data, outputfiles[i], row.names=FALSE)
}