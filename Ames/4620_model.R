#Propose  a  predictive  model  for  the  response  variable  using the train.dat training data and provide evidence of the appropriateness of your model

#load data
train <- read.csv("C:/Users/xbox/Desktop/Ames/train.csv",header = T)
test <- read.csv("C:/Users/xbox/Desktop/Ames/newAmestest.csv", header = T)

#Remove utilities variable from both data sets. This is a useless variable
#that causes problems with some r functions.
train = train[,-10]
test = test[,-10]
train = train[,-1]
test = test[,-1]

###STATR HERE####
#SalePrice is our target variable. According to the assumptions of Linear Regression,
#data should be normally distributed. By checking the distribution of SalePrice, 
#we can decide if we need non-linear transformation to make better prediction.
library(ggplot2)
ggplot(train, aes(x=SalePrice, fill = ..count..)) + 
  geom_histogram() +
  ggtitle('Histogram of SalePrice') + 
  xlab('Housing Price') +
  ylab('Count of Houses')
#SalePrice is skewed to right. Thus, a log term of SalePrice should be considered. 
train$lSalePrice = log(train$SalePrice)
train = train[,-79] #remove SalePrice

#Check for NAs and replace NAs with column medians
library(randomForest)
train = na.roughfix(train)
test = na.roughfix(test)
which(colSums(sapply(train, is.na))!=0)
which(colSums(sapply(test, is.na))!=0)

#Partition training set into training and validation
library(caret)
train_par = createDataPartition(train$lSalePrice, p = 0.8, list = FALSE) #p: percentage of data that goes to training
train_model = train[train_par,]
valid_model = train[-train_par,]

####Random Forest 1####
model1 = train(lSalePrice ~ ., data = train_model, method = 'rf', #random forest
                  nodesize= 10,              # 10 data-points/node. Speeds modeling
                  ntree =500,               # Default 500. Reduced to speed up modeling
                  trControl=trainControl(method="repeatedcv", number=2,repeats=1),  # cross-validation strategy
                  tuneGrid = expand.grid(mtry = c(123))
                  )
model1


################################Plotting Tree in Forest##########################
####Reference to function used - https://shiring.github.io/machine_learning/2017/03/16/rf_plot_ggraph ##############
library(tree)
library(dplyr)
library(ggraph)
library(igraph)

tree_func <- function(final_model, 
                      tree_num) {
  
  # get tree by index
  tree <- randomForest::getTree(final_model, 
                                k = tree_num, labelVar=TRUE) %>%
    tibble::rownames_to_column() %>%
    # make leaf split points to NA, so the 0s won't get plotted
    mutate(`split point` = ifelse(is.na(prediction), `split point`, NA))
  
  # prepare data frame for graph
  graph_frame <- data.frame(from = rep(tree$rowname, 2),
                            to = c(tree$`left daughter`, tree$`right daughter`))
  
  # convert to graph and delete the last node that we don't want to plot
  graph <- graph_from_data_frame(graph_frame) %>%
    delete_vertices("0")
  
  # set node labels
  V(graph)$node_label <- gsub("_", " ", as.character(tree$`split var`))
  V(graph)$split <- as.character(round(tree$`split point`, digits = 2))
  
  # plot
  plot <- ggraph(graph, 'dendrogram') + 
    theme_bw() +
    geom_edge_link() +
    geom_node_point() +
    geom_node_text(aes(label = node_label), na.rm = TRUE, repel = TRUE) +
    geom_node_label(aes(label = split), vjust = 2.5, na.rm = TRUE, fill = "white") +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          panel.background = element_blank(),
          plot.background = element_rect(fill = "white"),
          panel.border = element_blank(),
          axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          plot.title = element_text(size = 18))
  
  print(plot)
}


##### Get the index of the tree with the minimum number of nodes.
tree_num = which(model1$finalModel$forest$ndbigtree == min(model1$finalModel$forest$ndbigtree))

##### Plot the tree
tree_func(final_model = model1$finalModel, tree_num)


#make predictions on validation set
pred_valid = predict(model1, valid_model, type = 'raw')
pred_valid_df = data.frame(pred_valid)
pred_valid_df = cbind(valid_model$lSalePrice, pred_valid_df)
head(pred_valid_df,10)

#make predicitons on test set
pred = predict(model1, test, type = 'raw')
pred_df = data.frame(exp(pred))
pred_df = cbind(test$SalePrice, pred_df)
head(pred_df,10)

####Random Forest 2####
library(caret)
train_par = createDataPartition(train$lSalePrice, p = 0.8, list = FALSE) #p: percentage of data that goes to training
train_model = train[train_par,]
valid_model = train[-train_par,]
model2 = randomForest(lSalePrice ~., data = train_model, ntree = 500)
model2
plot(model2)
#although correlations in EDA are giving a good overview of the most important
#numeric values and multicolinearity among those variable, I want to get an overview
#of the most impoatant variables including the categorical variables as well.
varImpPlot(model2, n.var = 20, main = 'Variable Importance') #show variable importance/mean decrease in node impurity
importance(model2)
#validatoin
pred_valid2 = predict(model2, valid_model, type = 'response')
pred_valid2_df = data.frame(pred_valid2)
pred_valid2_df = cbind(valid_model$lSalePrice, pred_valid2_df)
head(pred_valid2_df,10)
#make predicitons on test set
pred2 = predict(model1, test, type = 'raw')
pred_df2 = data.frame(exp(pred))
pred_df2 = cbind(test$SalePrice, pred_df2)
colnames(pred_df2) = c('Actual SalePrice', 'Predicted SalePrice')
head(pred_df2,10)


#####Number of times a split occurs per variable#################
tree_num_M1_Max = which(model1$finalModel$forest$ndbigtree == max(model1$finalModel$forest$ndbigtree))

max_tree <- randomForest::getTree(model1$finalModel, 
                              k = tree_num_M1_Max, labelVar=TRUE)
splits = max_tree[3]

split_var_counts = count(splits)[order(-count(splits)$freq),]

head(split_var_counts,20)


####Check Accuracy####
plot(pred_valid,valid_model$lSalePrice, main = 'Predicted vs. Actual SalePrice (RF1)')
abline(0,1)
plot(pred_valid2,valid_model$lSalePrice, main = 'Predicted vs. Actual SalePrice (RF2)')
abline(0,1)

plot(exp(pred),test$SalePrice, main = 'Predicted vs. Actual SalePrice (RF)',ylab = 'Actual SalePrice', xlab = 'Predicted SalePrice using Random Forest')
abline(0,1)

####LASSO####
library(randomForest)
train = na.roughfix(train)
test = na.roughfix(test)
which(colSums(sapply(train, is.na))!=0)
which(colSums(sapply(test, is.na))!=0)

library(glmnet)
library(Metrics)
set.seed(123)
x = model.matrix(lSalePrice~.,train)[,-1]
y = train$lSalePrice
lasso.cv = cv.glmnet(x,y,alpha=1)
plot(lasso.cv)
bestlam = lasso.cv$lambda.min
bestlam

fit.lasso = glmnet(x,y,alpha=1, lambda=bestlam)
pred.lasso = predict(fit.lasso, newx = x)
coef(fit.lasso)

#prediction
test$lSalePrice = log(test$SalePrice)
test = test[,-79] #remove SalePrice

x1 = model.matrix(lSalePrice~., test)
x = model.matrix(lSalePrice~.,train)

####Check Accuracy####
pred_lasso = data.frame(pred.lasso)
pred_lasso_df = cbind(train$lSalePrice, pred_lasso)
head(pred_lasso_df,10)
plot(pred.lasso,train$lSalePrice, main = 'Predicted vs. Actual SalePrice (LASSO-Train)')
abline(0,1)




