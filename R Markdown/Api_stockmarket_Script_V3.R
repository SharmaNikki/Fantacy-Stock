#install.packages("dplyr")
install.packages("rjson")
install.packages("jsonlite")
install.packages("RCurl")
install.packages("lubridate")

#library(dplyr)
library(rjson)
library(jsonlite)
library(RCurl)
library(lubridate)

stockmarket <- function(n, st_ex){
   
  # *****************************************************#
  # Function Description - 
  # This function facilitates the buy/sell of stocks as per the following rules:
  #   1. You are limited to 2 calls per minute, maximum 300 API calls per day.
  #   2. You must make at least 250 successful trades (buy/sell) per day.
  #   3. All trading is to be done between 10am-4pm.
  #   
  # Input -
  #   n : Number of API calls to do. (Maximum allowed is 300)
  #   st_ex : List of stock symbols 
  # 
  # Output -
  #   This will check through all the conditions mentioned and buy/sell stocks alternatively for the list of stock symbols.
  # 
  # *****************************************************#
    
  if ((hour(now()) >= 10) & ((hour(now()) <= 15))){
    print("Welcome to Stock Marketing for the day!")
    calls_perday_limit <- n
    print("Your maximum API call limit - 300/day")
    
    stock_exc <- st_ex
    
    # Buy some initial stocks 
    for(bs in 1:length(stock_exc)){
      buy_url <- paste("https://projectrex.net/stocks/?key=3908807a &av_key=WAXKUU383HFZU74Y&request=buy&symbol=",stock_exc[bs],"&quantity=20", sep = "")
      buy_link <- URLencode(buy_url)
      buy_stock <- getURL(buy_link)
      calls_perday_limit <- calls_perday_limit - 1
    }
    st_count <- 1
    ptm <- proc.time()
    min_count <- 2
    buy <- 0
    # Continue to do buy/sell in stock market untill it exceeds the maximum API limit or untill it gets 16:00:00 hours
    while( (calls_perday_limit > length(stock_exc)) & (hour(now()) <= 15)){
      print(paste("API Calls pending - ",calls_perday_limit ))
      # Alternate the buy and sell of stocks
      if((min_count > 0) & (((proc.time() - ptm)[3]) < 60)){
        min_count <- min_count - 1
        if ((buy == 0)){
          print("Buying stock in progress..")
          buy_url <- paste("https://projectrex.net/stocks/?key=3908807a &av_key=WAXKUU383HFZU74Y&request=buy&symbol=",stock_exc[st_count],"&quantity=2", sep = "")
          buy_link <- URLencode(buy_url)
          buy_stock <- getURL(buy_link)
          print(buy_stock)
          #print(buy_link)
          buy <- 1
          calls_perday_limit <- calls_perday_limit - 1
        }else{
          print("Selling stock in progress..")
          Sys.sleep(30)
          sell_url <- paste("https://projectrex.net/stocks/?key=3908807a &av_key=WAXKUU383HFZU74Y&request=sell&symbol=",stock_exc[((length(stock_exc)-(st_count-1)))],"&quantity=2", sep = "")
          sell_link <- URLencode(sell_url)
          sell_stock <- getURL(sell_link)
          print(sell_stock)
          #print(sell_link)
          calls_perday_limit <- calls_perday_limit - 1
          st_count <- st_count + 1
          if(st_count > length(stock_exc)){
            st_count <- 1
          }
        }
      }else {
        print("Reseting counters!")
        if(((proc.time() - ptm)[3]) < 60){
          Sys.sleep(60 - ((proc.time() - ptm)))
        }
        ptm <- proc.time()
        min_count <- 2
        buy <- 0
        print("********************************")
      }
    }
    # Sell all the initial stocks brought during the beginning of process 
    if((hour(now()) <= 15)){
      for(ss in 1:length(stock_exc)){
        sell_url <- paste("https://projectrex.net/stocks/?key=3908807a &av_key=WAXKUU383HFZU74Y&request=sell&symbol=",stock_exc[ss],"&quantity=20", sep = "")
        sell_link <- URLencode(sell_url)
        sell_stock <- getURL(sell_link)
        calls_perday_limit <- calls_perday_limit - 1
      }
      print("Sorry! Exceeded the maximum limit of API call for a day")
      log_check <- readline(prompt="Do you want to print logs (Y/N): ")
      if(log_check == "Y"){
        print("Printing you the logs!!")
        log_link <- URLencode("https://projectrex.net/stocks/?key=3908807a &av_key=WAXKUU383HFZU74Y&request=log")
        logs <- getURL(log_link)
        fileConn<-file("logs.txt")
        writeLines(logs, fileConn)
        close(fileConn)
        print("The logs are available in logs.txt file.")
      }else{
        print("Thank You!")
      }
    }
  }else{
    profile_link <- URLencode("https://projectrex.net/stocks/?key=3908807a &av_key=WAXKUU383HFZU74Y&request=profile")
    prof <- getURL(profile_link)
    print(prof)
    print("Sorry! Stock Market is closed right now.Please trying running the script between 10:00:00 to 16:00:00")
  }
}

# ***************************************************** #

# Call the function passing the parameters
stockmarket(300, c("INTC","IBM","MSFT","CSCO"))

