# Fantacy-Stock
- AlphVantage API was used for the stock market competition with the below mentioned rules 
- Alpha Vantage Inc. is a leading provider of free APIs for realtime and historical data on stocks, forex (FX), and digital/crypto       currencies.

## Alpha Vantage Documentation: https://www.alphavantage.co/documentation/ 


# Rules:

- All trading must be done from R.
- You are limited to 2 calls per minute, maximum 300 API calls per day.
- You must make at least 250 successful trades (buy/sell) per day.
- All trading is to be done between 10am-4pm.
- Each violation of the rules results in a $1,000BDD penalty.

# AWS Instance (VM) 

- AWS EC2 instance was created to host R studio to automate the script
# Function Description 
##  This function facilitates the buy/sell of stocks as per the following rules:
### Input 
n : Number of API calls to do. (Maximum allowed is 300) 
st_ex : List of stock symbols 
### Output  
This will check through all the conditions mentioned and buy/sell stocks alternatively for the list of stock symbols.

# Library
## The libraries used for the function were 
- library(dplyr)
- library(rjson)
- library(jsonlite)
- library(RCurl)
- library(lubridate)

# Functions
## The functions used for the stock fantasy rules implementation :
- Nested if-else
- While statement 

# Decision Stock :Script
 The script is based on moving averages which helps to make decision to buy or sell stock based on the moving averages.

<a href="https://ibb.co/31bqtbb"><img src="https://i.ibb.co/5T3yq33/Imag2.png" alt="Imag2" border="0"></a>
<a href="https://ibb.co/K06t5w7"><img src="https://i.ibb.co/Gx7ZdTk/Image1.png" alt="Image1" border="0"></a>
