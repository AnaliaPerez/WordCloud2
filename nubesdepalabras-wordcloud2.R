#Nubes de palabras hechas con tweets de notorios políticos argentinos
#los tweets fueron capturados con el paquete Rtweet, las nubes fueron hechas con WordCloud2
#día 18-05-19, por Analía Perez

library(devtools)
devtools::install_github("lchiffon/wordcloud2")

library(tidytext)
library(tm)
library(dplyr)
library(stringr)
library(rtweet)
library(wordcloud2)

create_token(
  app = "el nombre de tu app",
  consumer_key = "xxxx",
  consumer_secret = "xxxx",
  access_token = "xxxxx",
  access_secret = "xxxx"
)


tweets_mm<-get_timeline("mauriciomacri", n=1500)


#sacar stop words en español, para eso "tomamos prestado" la lista de las mismas en español del paquete TM 
stopwordsespañol<-bind_rows(stop_words,
                            data_frame(word = tm::stopwords("spanish"),
                            lexicon = "custom"))


mm_text <- tweets_mm %>% 
  unnest_tokens(word, text) %>%
  anti_join(stopwordsespañol) %>%
  count(word, sort = TRUE)
 
#sacar otras palabras de acuerdo al caso
mmtexto <-mm_text %>%
  filter(!word %in% c('t.co', 'https', 'vivo'))
#ponía muchos videos en vivo, por eso la palabra más resaltada era "vivo". La saqué

#probamos una
wordcloud2(mmtexto, size = 0.7)

#y otra, con una silueta especial 
wordcloud2(mmtexto, figPath = "gato.png", size = 0.5)

#otros colores
wordcloud2(mmtexto, figPath = "gato.png", size= 0.5, color = "random-darks", backgroundColor = "yellow")

#hagamos el de Cristina Fernández
tweets_cfk<-get_timeline("CFKArgentina", n=1500)

cfk_text <- tweets_cfk %>% 
  unnest_tokens(word, text) %>%
  anti_join(stopwordsespañol) %>%
  count(word, sort = TRUE)

 cfk_text<-cfk_text %>%
  filter(!word %in% c('t.co', 'https', 'vivo','vez', 'ayer', 'día', 'ahora', 'dos', 'sino','casi', 'sólo'))

wordcloud2(cfk_text, figPath= "36189.png", size = 0.5)

wordcloud2(cfk_text, size = 0.5)

#y a Alberto Fernández también 
tweets_AF<-get_timeline("alferdez", n=1500)

AF_text <- tweets_AF %>% 
  unnest_tokens(word, text) %>%
  anti_join(stopwordsespañol) %>%
  count(word, sort = TRUE)

AF_text<-AF_text %>%
  filter(!word %in% c('t.co', 'https', 'vivo','vez','si', 'alferdez', 'ayer', 'día', 'ahora', 'dos', 'sino','casi', 'sólo'))

wordcloud2(AF_text, size = 0.5, color = 'random-light',backgroundColor = 'black')
