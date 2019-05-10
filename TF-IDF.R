#Advantage of TF-IDF: Relative freq of word
# -- calculate values for each word in a document to the percentage of document the word appears in. 
#1.Be able to distinguish unique terms with respect to a certain jargon better. 
#2.Adjust for the fact that some words appear more frequently in general (stopwords).

##############TF-IDF FUNCTION##############
library(tidyverse)
library(tidytext)
library(topicmodels)
library(tm)
library(SnowballC)
top_terms_by_topic_tfidf <- function(text_df, text_column, group_column, plot){
  group_column <- enquo(group_column)
  text_column <- enquo(text_column)
  
  words <- text_df %>%
    unnest_tokens(word, !!text_column) %>%
    count(!!group_column, word) %>% 
    ungroup()
  total_words <- words %>% 
    group_by(!!group_column) %>% 
    summarize(total = sum(n))
  words <- left_join(words, total_words)
  
  tf_idf <- words %>%
    bind_tf_idf(word, !!group_column, n) %>%
    select(-total) %>%
    arrange(desc(tf_idf)) %>%
    mutate(word = factor(word, levels = rev(unique(word))))
  
  if(plot == T){
    group_name <- quo_name(group_column)
    tf_idf %>% 
      group_by(!!group_column) %>% 
      top_n(10) %>%  #show top 5 words
      ungroup %>%
      ggplot(aes(word, tf_idf, fill = as.factor(group_name))) +
      geom_col(show.legend = FALSE) +
      labs(x = NULL, y = "tf-idf") +
      facet_wrap(reformulate(group_name), scales = "free") +
      coord_flip()
  }else{
    return(tf_idf)
  }
}

##TEST DF##
library(readr)
VERBATIMS <- read_csv("R/PQS_Shiny/VERBATIMS.csv") 
VERBATIMS$VERBATIM = gsub('[[:digit:]][[:punct:]]','',VERBATIMS$VERBATIM) #remove digits + punctuation characters
VERBATIMS$VERBATIM = iconv(VERBATIMS$VERBATIM, 'UTF-8','UTF-8',sub = '') #remove invalid UTF-8
VERBATIMS$VERBATIM = removeWords(VERBATIMS$VERBATIM, stop_words$word)
#CALL FUNCTION#
top_terms_by_topic_tfidf(text_df = VERBATIMS, 
                         text_column = VERBATIM , 
                         group_column = MAKE, 
                         plot = T) 

