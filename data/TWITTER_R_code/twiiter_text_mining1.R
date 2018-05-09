library(twitteR)
library(RColorBrewer)
library(dplyr)
library(plyr)
library(Rserve)
#Rserve()
#.jinit()
library(rJava)
library(KoNLP)

BEGGING_SEARCHING_DATE = '2018-05-02'
END_OF_SEARCHING_DATE = '2018-05-03'
DATE = 20180502
PM10 = 44  
PM2p5 = 35
O3 = 0.022
NO2 = 0.026
CO = 0.5
SO2 = 0.003
TEXTNAME = "_20180502.txt"
# http://cleanair.seoul.go.kr/air_city.htm?method=measure&citySection=CITY
###########################################################################

SAVE_PATH = "/Users/leejunho/Desktop/git/python3Env/group_study/ko_stats/data/SEOUL/ALL_DATA/TWITTER/"
KEY_WORD = c('날씨','건강','병원','미세먼지','짜증','중국','공기','정부','삼겹살','여행','기분','걱정','환경','나무','희망',"ㅁㅊ","학교","술","먼지","사랑","출근","한국","환기","서울","대책","오염") 
FILTER = '-filter:retweets'
SAVE_FILE_NAME = c("WEATHER",'HEALTH','HOSPITAL','PM','ANXIOUS','CHINA','AIR','POLITIC','PORK','TRAVEL','FEELING','WORRY','ENV','TREE','HOPE',"CRAZZY","SCHOOL","ALCOHOL","DUST","LOVE","WORK","KOREA","CHANGE_AIR","SEOUL","ALTERNATIVE","POLLUTION")
#날씨, 건강, 병원, 미세먼지, 짜증, 중국, 공기, 정부, 삼겹살, 여행
###########################################################################  

for (j in 1:length(KEY_WORD)){
  KEY_WORD_THIS = paste(KEY_WORD[j],FILTER,sep=" ")
  SAVE_FILE_NAME_THIS = paste(SAVE_PATH,SAVE_FILE_NAME[j],sep="")
  SAVE_FILE_NAME_THIS = paste(SAVE_FILE_NAME_THIS,TEXTNAME,sep="")
    
  SAVE_RAWFILE_NAME_THIS = paste("RAW_",SAVE_FILE_NAME[j],sep="")
  SAVE_RAWFILE_NAME_THIS = paste(SAVE_PATH,SAVE_RAWFILE_NAME_THIS,sep="")
  SAVE_RAWFILE_NAME_THIS = paste(SAVE_RAWFILE_NAME_THIS,TEXTNAME,sep="")
  #SOUTH_KOREA = '35.549684,127.094529,300km'
  SEOUL = "37.554131,126.989540,20km"
  iphone_t = searchTwitter(KEY_WORD_THIS,n=1000,geocode=SEOUL, since=BEGGING_SEARCHING_DATE ,until=END_OF_SEARCHING_DATE)
  #head(iphone_t,5)
  iphone_tweet = laply(iphone_t, function(t) t$getText())
  head(iphone_tweet,5)
  iphone_tweet = gsub('[[:punct:]]','',iphone_tweet)
  iphone_tweet = gsub("[[:cntrl:]]","",iphone_tweet)
  iphone_tweet = gsub("http:[^ $]+","",iphone_tweet)
  iphone_tweet = gsub("\\d+","", iphone_tweet)
#  head(iphone_tweet,5)

  pos.word = scan("positive-words-ko-v2.txt", what = "character", comment.char = ";")
  neg.word = scan("negative-words-ko-v2.txt", what = "character", comment.char = ";")

  for (i in 1:length(iphone_tweet)){
    word.list = str_split(iphone_tweet[i],"\\s+")
    words = unlist(word.list)
  #  print(words)
    total=length(words); #print(total)
    pos.match = match(words, pos.word); pos.match = !is.na(pos.match); pos.score = sum(pos.match); 
    neg.match = match(words, neg.word); neg.match = !is.na(neg.match); neg.score = sum(neg.match); 
  #  print(pos.score)
  #  print(neg.score)
  #  print("**")
    RAWlist = c(iphone_tweet)
    soolist = c(DATE, PM10, PM2p5, O3, NO2, CO, SO2, total, pos.score, neg.score, pos.score/total, neg.score/total)
   if(i==1)
    {
      Msoolist = matrix(soolist, nrow=1,byrow = T)
      #MRAWlist = RAWlist
    }  
  
    else{
      Fsoolist = matrix(soolist, nrow=1,byrow = T)
      Msoolist <- rbind(Msoolist, Fsoolist)
      #FRAWlist = matrix(RAWlist, nrow=1,byrow = T)
      #MRAWlist <-rbind(MRAWlist, FRAWlist)
    }   
  #  print(Msoolist)
  }
write.table(Msoolist, SAVE_FILE_NAME_THIS , row.names =F, col.names =c("DATE","PM10","PM2p5","O3","NO2","CO","SO2","TOT_WORD","POS_NUM","NEG_NUM","POS_PRO","NEG_PRO")  ,quote = F )
write.table(data.frame(iphone_tweet), SAVE_RAWFILE_NAME_THIS , row.names =T, col.names =F ,quote = F )
}
warnings()

#iphone_tweet = iphone_tweet[!Encoding((iphone_tweet))=="UTF-8"] 
#apple_scores = score.sentiment(iphone_tweet, pos.word, neg.word, .progress="text")
#apple_words = apple_scores$text
#head(apple_words,10) 
#length(apple_words)
#apple_words = gsub("https:[^ $]+","",apple_words)
#apple_words = gsub("[[:cntrl:]]", "",apple_words)
#Score_of = apple_scores$score
#print(Score_of)





