# Load required packages
library(biganalytics)

# Set working directory
setwd("~/Stat480/group-project")

# Function to apply to a CSV file to convert a list of columns to integer index values.
convertCSVColumns <- function(file,factorCols,strCols,floatCols,intCols){
  fulldata<-read.csv(file, header=TRUE)
  colnames(fulldata) <- sapply(colnames(fulldata),
                               function(x) strsplit(x, "[.]")[[1]][2])
  cols <- colnames(fulldata)
  # cleaning values of all columns
  for(i in 1:ncol(fulldata)){
    fulldata[,i]<-gsub('"','',fulldata[,i]) # replace " with (blanks)
    navals<-is.na(fulldata[,i])
    tmp<-(fulldata[!navals,i]=="NULL") | (fulldata[!navals,i]=="")
    fulldata[!navals,i][tmp]<-NA # replace NULL values with NA values
  }
  rm(tmp)
  gc()
  # split planeissuedate in mm, dd, yyyy
  navals<-is.na(fulldata[,"planeissuedate"])
  tmp<-(fulldata[!navals,"planeissuedate"]=="None")
  fulldata[!navals,"planeissuedate"][tmp]<-NA # replace None values with NA values
  fulldata<-cbind(fulldata, matrix(NA, nrow(fulldata), 3,
                                   dimnames=list(NULL,c("planeissuemonth",
                                                        "planeissueday",
                                                        "planeissueyear")))) # append 3 columns
  fulldata[!navals,"planeissuemonth"]<-substr(fulldata[!navals,"planeissuedate"],
                                              1, 2) # planeissuemonth
  fulldata[!navals,"planeissueday"]<-substr(fulldata[!navals,"planeissuedate"],
                                              3, 4) # planeissueday
  fulldata[!navals,"planeissueyear"]<-substr(fulldata[!navals,"planeissuedate"],
                                              5, 8) # planeissueyear
  intCols<-c(intCols,51:53)
  
  # replacing factors with integers
  for(i in factorCols){
    navals<-is.na(fulldata[,i]) # do not convert NA values to factors
    fulldata[!navals,i]<-convertFactorColumn(fulldata[!navals,i], cols[i])
    fulldata[,i]<-as.numeric(fulldata[,i])
  }
  # format float columns
  for(i in floatCols){
    fulldata[,i]<-as.numeric(fulldata[,i])
  }
  # format int columns
  for(i in intCols){
    fulldata[,i]<-round(as.numeric(fulldata[,i]))
  }
  
  # save na value counts
  navalsSum<<-sapply(1:ncol(fulldata),
                     function(x) sum(is.na(fulldata[,x])))
  #names(navalsSum)<<-colnames(fulldata)
  
  # make csv for integer cols
  write.csv(fulldata[,-c(strCols, floatCols, 45)], file, row.names=FALSE) # col 45=planeissuedate
  # make csv for float cols
  write.csv(fulldata[,floatCols], "AirlineData0205Float.csv", row.names=FALSE)
}

# The following function is called by convertCSVColumns.
# It converts a single column to integer indices.
# It also stores unique levels of a column in variable 'colMappings'.
convertFactorColumn <- function(values, name){
  allvals<-as.character(values)
  valslist<-sort(unique(allvals))
  xx<-factor(allvals, valslist, labels=1:length(valslist))
  colMappings[[name]] <<- valslist
  rm(allvals)
  rm(valslist)
  gc()
  as.numeric(levels(xx))[xx]
}

# Column numbers with non-integer data
factorCols<-c(9,11,17,18,23,31:33,37:39,43:49)
strCols<-c(30,36,42)
floatCols<-c(34:35,40:41)
intCols<-c(1:50)[!(1:50 %in% c(factorCols, strCols, floatCols))]
# Placeholder to store unique values of columns containining non-integer data
colMappings <- list()
navalsSum<-c()
# Format columns for making big matrices
# and time the process
pt<-proc.time()
convertCSVColumns("AllAirlineData0205.csv", factorCols, strCols,floatCols,intCols)
proc.time()-pt
# Save unique values of columns containing non-integer data
# in a R data set for future use
save(colMappings, file="nonintegerColFactors.Rda")

# Convert csv data to big matrix objects
data <- read.big.matrix("AllAirlineData0205.csv", header = TRUE,
                        backingfile = "air0205.bin",
                        descriptorfile = "air0205.desc",
                        type="integer")
latlong <- read.big.matrix("AirlineData0205Float.csv", header = TRUE,
                           backingfile = "air0205float.bin",
                           descriptorfile = "air0205float.desc",
                           type="double")
