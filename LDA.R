#########################LDA FUNCTION######################3#
library(tidyverse)
library(tidytext)
library(topicmodels)
library(tm)
library(SnowballC)
top_terms_by_topic_LDA = function(input_text,plot=T,number_of_topics){
  corpus = Corpus(VectorSource(input_text))
  DTM = DocumentTermMatrix(corpus)
  unique_indexes <- unique(DTM$i)
  DTM <- DTM[unique_indexes,]
  lda <- LDA(DTM, k = number_of_topics, control = list(seed = 1234))
  topics <- tidy(lda, matrix = "beta")
  top_terms <- topics  %>% 
    group_by(topic) %>% 
    top_n(5, beta) %>%  
    ungroup() %>%
    arrange(topic, -beta)
  if(plot == T){
    top_terms %>%
      mutate(term = reorder(term, beta)) %>%
      ggplot(aes(term, beta, fill = factor(topic))) +
      geom_col(show.legend = FALSE) +
      facet_wrap(~ topic, scales = "free") +
      labs(x = NULL, y = "Beta") +
      coord_flip() 
  }else{ 
    return(top_terms) }
}

###################################################################
library(readr)
VERBATIMS <- read_csv("R/PQS_Shiny/VERBATIMS.csv")
VERBATIMS_Q38 = VERBATIMS[VERBATIMS$Q_NUM==38,]

commonWords = c("and","i","the")

VERBATIMS_Q38 = 
  VERBATIMS_Q38$VERBATIM %>%
  na.omit() %>%
  #tolower() %>%
  gsub("[[:punct:]]","",.) %>%
  gsub('[[:digit:]]+', '',.) %>%  
  removeWords(., stop_words$word) %>%
  removeWords(.,commonWords)  

top_terms_by_topic_LDA(VERBATIMS_Q38, number_of_topics = 15) 

