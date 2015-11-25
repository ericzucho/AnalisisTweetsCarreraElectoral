if(!require("twitteR")){install.packages("twitteR")}
if(!require("base64enc")){install.packages("base64enc")}
if(!require("stringr")){install.packages("stringr")}

init_cred <- function(){
  twitter_cred <- list()
  twitter_cred$consumer_key <- "GpaD2P4Ow1B9YyOdb9d2sYWAs" #Add key here
  twitter_cred$consumer_secret <- "HlrnP3S0LobfKTL3UzJVGbf1XolVmct0AnVdJFYJkKraf2f4BN" #Add key here
  twitter_cred$access_token <- "3650040494-7FhQ0uPpi2Q0gBK4RuWQlPyyIjSoJ3ljqsOBglq" #Add key here
  twitter_cred$access_secret <- "eIf4rjHocwOQMB5pQ3J9XULFLNx3fmZm576aAfZCITR0E" #Add key here
  write.csv(twitter_cred, file=paste(getwd(),"/twitter_cred.csv",sep=""))
}

init_cred()
twitter_cred <- read.csv(paste(getwd(),"/twitter_cred.csv",sep=""), stringsAsFactors = FALSE)
setup_twitter_oauth(twitter_cred$consumer_key, twitter_cred$consumer_secret, twitter_cred$access_token, twitter_cred$access_secret)



keyWords <- c("#RandPaul2016","@LincolnChaffee","@RandPaul","#LincolnChaffee","#HillaryClinton","#Hillary2016")

yesterday <- "2015-10-13"
today <- "2015-10-14"


for (word in 1:length(keyWords)) {
  
  ds <- searchTwitter(keyWords[word],n=200000, since=yesterday, until=today, locale = NULL)
  
  df1 <- twListToDF(ds)
  df1$keyword <- keyWords[word]
  write.csv(df1, file=paste(getwd(),"/",keyWords[word],"-",yesterday,".csv",sep=""))
}

