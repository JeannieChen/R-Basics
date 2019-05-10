##Function that will take a large CSV file in location X, split it up Y number of times,
##then write it back in Z location with N[i] as the file name, and CN as the column names.

#CN is optional 
ChuckFilet <- function(X,Y,Z = "~.//", N = "file", CN, OMIT = FALSE){

##Columns names for single use case (not necessary)
  ColumnNames <- c("VIN","Make","Model","Model.Year","Sale.Date","Mileage.Source",
                   "Mileage.Capture.Date","Mileage","City","State","ZipCode")
  
##Required packages    
    library(lubridate)
    library(dplyr)

##Save and Print the number of rows in the file *this can take some time  
    NumberOfRows <-length(count.fields(X))
    print(NumberOfRows)
##SplitIncrements    
    SplitIncrements <- round(NumberOfRows / Y)
##Initialize empty list to read items into and write items out of    
    TempList <- list()
##Initialize empty list to capture all records that have NAs to clean them    
    TempListMess <<- list()
    
##Initialize j counter and read in files as long as j < Y   
    
          for(i in 1:Y){
            
          j <- i-1  
##Read in files of 'splitincrement' length with optional provided column names and convert all blanks to NA      
          TempList[[i]] <- read.csv(file = X, 
                                    nrows = SplitIncrements, 
                                    skip = j *SplitIncrements, 
                                    col.names = CN,
                                    na.strings = "")
          
##Catch all the records that contained blanks or NAs and save them as a data.frame for further processing          
          if(OMIT == TRUE){
          TempListMess[[i]] <<- filter(TempList[[i]], !complete.cases(TempList[[i]])) }

##Convert date columns          
          TempList$Sale.Date 
          TempList$Mileage.Capture.Date <- mdy(na.omit(TempList$Mileage.Capture.Date))
          TempList$Mileage.Capture.Date
          
##Write files back using the provided parameters omitting all records that include NAs
          write.csv(
            
                    if(OMIT == TRUE){
                    na.omit(TempList[[i]])}
                    else{
                    TempList[[i]]},
                    
                    paste(Z,N,i,".csv", sep = ""),
                    row.names = FALSE)

##Null each chunk to reduce in memory storage
          TempList[[i]] <- NULL
          print(paste("File ",i," complete", sep = ''))
          
   }

#TempListMess

}