library(jsonlite)
for(i in 1:200){
  errorCondition=0;
  while (errorCondition==0)
    errorCondition=1
    tryCatch({
      
      if(is.na(US_customers$Census.Block[i])){
        
        
        message("geocoding address #",i, " ", US_customers$Address[i], ', ',US_customers$City[i], ', ',US_customers$State[i] )
        
        query=gsub(" ","",paste("https://geocoding.geo.census.gov/geocoder/geographies/address?street=",gsub(" ","+", US_customers$Address[i],fixed = TRUE),"&city=",gsub(" ","+", US_customers$City[i],fixed = TRUE),"&state=",gsub(" ","+", US_customers$State[i],fixed = TRUE),"&benchmark=Public_AR_Census2010&vintage=Census2010_Census2010&layers=14&format=json"))
        
        resp<-fromJSON(query)
        
        censusblock<-resp$result$addressMatches$geographies$`Census Blocks`[[1]]$GEOID
        if (is.null(censusblock)){
          US_customers$Census.Block[i]<-"Not found"
        }
        else{
          US_customers$Census.Block[i]<-censusblock
        }
        
        message("census block is, ", censusblock)
        
      }
    }, error=function(cond) {
      message('can\'t connect to server')
      message("Here's the original error message:")
      message(cond)
      # Choose a return value in case of error
      errorCondition=0;
      n=1
      message("sleeping for ",n ," seconds." )
      
    }
    
    )
  
  
}