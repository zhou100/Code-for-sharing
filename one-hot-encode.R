

OUTPUT_SEASONS <- read_csv("Desktop/OUTPUT_SEASONS.csv")

# create a column to save the sequence  
OUTPUT_SEASONS["Plant_Months"] =""

# For loop, over differents rows 
for (RowIndex in 1:nrow(OUTPUT_SEASONS)){
  
  temp.start.month = OUTPUT_SEASONS$Plant_SM[RowIndex] # get the start month 
  
  temp.end.month = OUTPUT_SEASONS$Plant_EM[RowIndex] # get the end month 
   
  # normal case 
  if(temp.start.month<=temp.end.month & !is.na(temp.start.month) & !is.na(temp.end.month)){
    
    sequence = seq(from=temp.start.month, to=temp.end.month, by=1) # sequence of start to end month
  
  # end < start case   
  } else if(!is.na(temp.start.month) & !is.na(temp.end.month) ){
    
    ## Note: this needs more than a month dummy, but also need to add another indicator that the month with small numbers
    #  are is in the next year
    sequence.year1 = seq(from=temp.start.month, to=12, by=1)
    sequence.year2 = seq(from=1, to=temp.end.month, by=1)
    sequence  =  c(sequence.year1,sequence.year2)
  }

  # save sequence as strings, separated by ","
 OUTPUT_SEASONS$Plant_Months[RowIndex] = toString(sequence) 
 
} # Loop over rows 


library(splitstackshape)  
library(data.table)

# one-hot encoding 
OUTPUT_SEASONS = cSplit_e(as.data.table(OUTPUT_SEASONS),"Plant_Months",",",type="character",fill = 0)
 