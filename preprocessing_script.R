if(!require("base64enc")){install.packages("base64enc")}
if(!require("stringr")){install.packages("stringr")}

#connect all libraries
library(twitteR)
library(ROAuth)
library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)

#days <- c('2015-10-17','2015-10-18','2015-10-19','2015-10-20','2015-10-21','2015-10-22','2015-10-23','2015-10-24','2015-10-25','2015-10-26','2015-10-27','2015-10-28','2015-10-29','2015-10-30','2015-10-31','2015-11-01','2015-11-02','2015-11-03','2015-11-04','2015-11-05','2015-11-06','2015-11-07','2015-11-08','2015-11-09','2015-11-10','2015-11-11','2015-11-12','2015-11-13','2015-11-14','2015-11-15','2015-11-16','2015-11-17')
days <- c('2015-10-17','2015-10-18','2015-10-19','2015-10-20','2015-10-21','2015-10-22','2015-10-23','2015-10-24','2015-10-25','2015-10-26','2015-10-27','2015-10-28','2015-10-29','2015-10-30','2015-10-31','2015-11-01','2015-11-02','2015-11-03','2015-11-04','2015-11-05','2015-11-06','2015-11-07')
#days <- c('2015-10-17')
allKeywords <- c("@RandPaul","#RandPaul2016","@LincolnChaffee","#LincolnChaffee","#HillaryClinton","#Hillary2016","Hillary2016","@HillaryClinton","@MartinOMalley","@BernieSanders","#BernieSanders","@JimWebbUSA","@JebBush","@RealBenCarson","#BenCarson2016","@ChrisChristie","@TedCruz","#TedCruz2016","@CarlyFiorina","@LindseyGrahamSC","@BobbyJindal","@JohnKasich","@GovernorPataki","@MarcoRubio","@RickSantorum","@RealDonaldTrump","#Trump2016","#TrumpForPresident","@GOP","@TheDemocrats","#DemDebate","#DebateWithBernie","#DamnEmails","#MakeAmericaGreatAgain","#BC2DC16","#carlyforpresident","#StandWithRand","#LibertyNotHillary","#DumpTrump","#DontGetBerned","#Bernie2016","#FiorinaForWomen","#PresidentPaul","#NotBush","#LatinosForHillary","#ImWithHer","#CruzCrew","#CruzCrowd","#Carly2016")
republicanKeywords <- c("@RandPaul","#RandPaul2016","@JebBush","@RealBenCarson","#BenCarson2016","@ChrisChristie","@TedCruz","#TedCruz2016","@CarlyFiorina","@LindseyGrahamSC","@BobbyJindal","@JohnKasich","@GovernorPataki","@MarcoRubio","@RickSantorum","@RealDonaldTrump","#Trump2016","#TrumpForPresident","@GOP","#MakeAmericaGreatAgain","#BC2DC16","#carlyforpresident","#StandWithRand","#LibertyNotHillary","#DontGetBerned","#FiorinaForWomen","#PresidentPaul","#CruzCrew","#CruzCrowd","#Carly2016","#DamnEmails")
vsDemocrat <- c("#DamnEmails")
#REPUBLICANOS
RandPaul <- c("@RandPaul","#RandPaul2016","#StandWithRand","#PresidentPaul")
JebBush <- c("@JebBush")
BenCarson <- c("@RealBenCarson","#BenCarson2016","BC2DC2016")
ChrisChristie <- c("@ChrisChristie")
TedCruz <- c("@TedCruz","#TedCruz2016","#CruzCrew","#CruzCrowd")
FiorinaCarly <- c("@CarlyFiorina","#carlyforpresident","#FiorinaForWomen","#Carly2016")
LindseyGraham <- c("@LindseyGrahamSC")
BobbyJindal <- c("@BobbyJindal")
JohnKasich <- c("@JohnKasich")
Pataki <- c("@GovernorPataki")
MarcoRubio <- c("@MarcoRubio")
RickSantorum <- c("@RickSantorum")
DonaldTrump <- c("@RealDonaldTrump","#Trump2016","#TrumpForPresident","#MakeAmericaGreatAgain")
#Democratas
democratKeywords <- c("@LincolnChaffee","#LincolnChaffee","#HillaryClinton","Hillary2016","#Hillary2016","@HillaryClinton","@MartinOMalley","@BernieSanders","#BernieSanders","@JimWebbUSA","@TheDemocrats","#DemDebate","#DebateWithBernie","#DumpTrump","#Bernie2016","#NotBush","#LatinosForHillary","#ImWithHer")
vsRepublican <- c("#DumpTrump","#NotBush")
LincolnChaffee <- c("@LincolnChaffee","#LincolnChaffee")
HillaryClinton <- c("#HillaryClinton","#Hillary2016","@HillaryClinton","#LatinosForHillary","#ImWithHer","Hillary2016")
MartinOMalley <- c("@MartinOMalley")
BernieSanders <- c("@BernieSanders","#BernieSanders","#DebateWithBernie","#Bernie2016")
JimWebb <- c("@JimWebbUSA")


uselessColumns <- c("favorited","favoriteCount","replyToSN","truncated","replyToSID","replyToUID","statusSource","isRetweet","retweeted","longitude","latitude")

simplifiedOutputRepDem <- c()
simplifiedOutputCandidates <- c()


for (day in 1:length(days)) {
  wholeDay <- data.frame()
  #Get all files for a given day
  #files <- dir(path = "D:/Users/Eric/Documents/Google Drive/Eric/Universidad/Sï¿½ptimo semestre/Progra Avanzada/ProyectoFinal/CSVs", pattern = paste(days[day],'.csv'), all.files = FALSE,
  #           full.names = FALSE, recursive = FALSE,
  #           ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)
  for (word in 1:length(allKeywords)) {
    #Read each particular file
    try(
      {
    df1 <- read.csv(paste("D:/Users/Eric/Documents/Google Drive/Eric/Universidad/Séptimo semestre/Progra Avanzada/ProyectoFinal/CSVs/",allKeywords[word],"-",days[day],".csv",sep = ""), stringsAsFactors = FALSE)
    df1 <- df1[, !(colnames(df1) %in% uselessColumns)]
    if (word == 1) {
      wholeDay <- read.csv(paste("D:/Users/Eric/Documents/Google Drive/Eric/Universidad/Séptimo semestre/Progra Avanzada/ProyectoFinal/CSVs/",allKeywords[word],"-",days[day],".csv",sep = ""), stringsAsFactors = FALSE)
      wholeDay <- wholeDay[0,]
      
    }
    keyWord <- df1[,c("keyword")]
    
    #if (word>1) {
    #  #If keyword is not the first one, delete row if it has one of the previous keywords
    #  for (previousKeyword in 1:(word - 1)) {
    #    df1 <- df1[!(previousKeyword %in% df1$text), ] 
    #  }
    #}
    text <- df1[,c("text")]
    
    #Republican or democrat?
    df1$republican <- (keyWord %in% republicanKeywords)
    
    #It is first assumed all tweets are positive
    df1$positive <- ifelse(TRUE,1,0)
    df1$candidate <- ifelse(TRUE,"",0)
    
    #Which candidate does it belong to?

    df1$candidate <- ifelse(keyWord %in% RandPaul,"RandPaul",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% JebBush,"JebBush",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% BenCarson,"BenCarson",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% ChrisChristie,"ChrisChristie",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% TedCruz,"TedCruz",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% FiorinaCarly,"FiorinaCarly",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% LindseyGraham,"LindseyGraham",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% BobbyJindal,"BobbyJindal",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% JohnKasich,"JohnKasich",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% Pataki,"Pataki",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% MarcoRubio,"MarcoRubio",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% RickSantorum,"RickSantorum",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% DonaldTrump,"DonaldTrump",df1$candidate)

    df1$positive <- ifelse(keyWord %in% c("#DumpTrump"),0,df1$positive)
    df1$candidate <- ifelse(keyWord %in% c("#DumpTrump"),"DonaldTrump",df1$candidate)

    df1$candidate <- ifelse(keyWord %in% LincolnChaffee,"LincolnChaffee",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% HillaryClinton,"HillaryClinton",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% MartinOMalley,"MartinOMalley",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% BernieSanders,"BernieSanders",df1$candidate)
    df1$candidate <- ifelse(keyWord %in% JimWebb,"JimWebb",df1$candidate)

    df1$positive <- ifelse(keyWord %in% c("#DamnEmails"),0,df1$positive)
    df1$candidate <- ifelse(keyWord %in% c("#DamnEmails"),"HillaryClinton",df1$candidate)
    df1$positive <- ifelse(keyWord %in% c("#NotBush"),0,df1$positive)
    df1$candidate <- ifelse(keyWord %in% c("#NotBush"),"JebBush",df1$candidate)
    
    
    #########SIENTIMENT ANALYSIS HERE##########
    #tweets evaluation function
    score.sentiment <- function(sentences, pos.words, neg.words, .progress='none')
    {
        require(plyr)
        require(stringr)
        scores <- laply(sentences, function(sentence, pos.words, neg.words){
            sentence <- gsub('[[:punct:]]', "", sentence)
            sentence <- gsub('[[:cntrl:]]', "", sentence)
            sentence <- gsub('\\d+', "", sentence)
            #sentence <- tolower(sentence)
            word.list <- str_split(sentence, '\\s+')
            words <- unlist(word.list)
            pos.matches <- match(words, pos.words)
            neg.matches <- match(words, neg.words)
            pos.matches <- !is.na(pos.matches)
            neg.matches <- !is.na(neg.matches)
            score <- sum(pos.matches) - sum(neg.matches)
            return(score)
        }, pos.words, neg.words, .progress=.progress)
        scores.df <- data.frame(score=scores, text=sentences)
        return(scores.df)
    }
    
    pos <- scan(file='D:/Users/Eric/Documents/Google Drive/Eric/Universidad/Séptimo semestre/Progra Avanzada/ProyectoFinal/positive-words.txt', what='character', comment.char=';') #folder with positive dictionary
    neg <- scan(file='D:/Users/Eric/Documents/Google Drive/Eric/Universidad/Séptimo semestre/Progra Avanzada/ProyectoFinal/negative-words.txt', what='character', comment.char=';') #folder with negative dictionary
    pos.words <- c(pos, 'upgrade', 'gusta')
    neg.words <- c(neg, 'wtf', 'wait', 'waiting', 'epicfail')
    
    scores <- score.sentiment(df1$text, pos.words, neg.words, .progress='text')
    df1$positive <- ifelse(scores$score >=0,1,0)
    
    party <- ifelse(df1$republican,"Republican","Democrat")
    
    toAppend1 <- c(paste(party,days[day],df1$positive,sep = "#"))
    toAppend2 <- c(paste(df1$candidate,days[day],df1$positive,sep = "#"))
    #toAppend2 <- subset(toAppend2,grepl("^[a-z][A-Z]+#.*$"))
    toAppend2Alt <- toAppend2[grep("^[^#]+#.*$", toAppend2)]
    
    simplifiedOutputRepDem <- c (simplifiedOutputRepDem, toAppend1)
    simplifiedOutputCandidates <- c (simplifiedOutputCandidates, toAppend2Alt)
    
    #Add to the whole day file the current candidate data.
    #  wholeDay <- rbind(wholeDay,df1)
      }
    )
  }
  #wholeDay <- subset(wholeDay, !duplicated(subset(wholeDay, select=c(text, screenName))))
  #write.csv(wholeDay, file=paste("D:/Users/Eric/Documents/Google Drive/Eric/Universidad/Séptimo semestre/Progra Avanzada/ProyectoFinal/",days[day],".csv",sep = ""))
  write(simplifiedOutputRepDem, file=paste("D:/Users/Eric/Documents/Google Drive/Eric/Universidad/Séptimo semestre/Progra Avanzada/ProyectoFinal/RepDem",days[day],".txt",sep = ""))
  write(simplifiedOutputCandidates, file=paste("D:/Users/Eric/Documents/Google Drive/Eric/Universidad/Séptimo semestre/Progra Avanzada/ProyectoFinal/Cand",days[day],".txt",sep = ""))
}

