library(ggplot2)
library(RColorBrewer)
library(plotly)
library(reshape2)

#Date format
data$Date = as.Date(data$Date, format = "%b %d, %Y")

#Define the func that will be used in dcast()
f.agg <- function(x) unique(x)[1]

### 1st Matrix (for Vehicle Daily Status == 1)
#Mark 1 in f1 column if Vehicle Daily Status == 1, otherwise NA
data$f1 = ifelse(data$`Vehicle Daily Status`== "1",1,NA)

#Convert df into matrix: Row = Vehicle ID, Col = Date, Fill = returned value from f.agg
f1 = dcast(data[,c('Date','Vehicle ID','f1')], `Vehicle ID` ~ Date, fun.aggregate = f.agg)

#Remove row name column
f1 = data.matrix(f1[,2:ncol(f1)])

#Define colorset
f1Color <- data.frame(x = c(0,1), y = c("#d60404", "#d60404"))

#Define colorset colname
colnames(f1Color) <- NULL

### 2nd Matrix
data$f2 = ifelse(data$`Vehicle Daily Status`== "2",1,NA)
f2 = dcast(data[,c('Date','Vehicle ID','f2')], `Vehicle ID` ~ Date, fun.aggregate = f.agg)
f2 = data.matrix(f2[,2:ncol(f2)])
f2Color <- data.frame(x = c(0,1), y = c("#b4f7ad", "#b4f7ad"))
colnames(f2Color) <- NULL

### 3rd Matrix
data$f3 = ifelse(data$`Vehicle Daily Status`== "3",1,NA)
f3 = dcast(data[,c('Date','Vehicle ID','f3')], `Vehicle ID` ~ Date, fun.aggregate = f.agg)
f3 = data.matrix(f3[,2:ncol(f3)])
f3Color <- data.frame(x = c(0,1), y = c("#6eb567", "#6eb567"))
colnames(f3Color) <- NULL

### 4th Matrix
data$f4 = ifelse(data$`Vehicle Daily Status`== "4",1,NA)
f4 = dcast(data[,c('Date','Vehicle ID','f4')], `Vehicle ID` ~ Date, fun.aggregate = f.agg)
f4 = data.matrix(f4[,2:ncol(f4)])
f4Color <- data.frame(x = c(0,1), y = c("#35702e", "#35702e"))
colnames(f4Color) <- NULL

### 5th Matrix
data$f5 = ifelse(data$`Vehicle Daily Status`== "5",1,NA)
f5 = dcast(data[,c('Date','Vehicle ID','f5')], `Vehicle ID` ~ Date, fun.aggregate = f.agg)
f5 = data.matrix(f5[,2:ncol(f5)])
f5Color <- data.frame(x = c(0,1), y = c("#ffaa49", "#ffaa49"))
colnames(f5Color) <- NULL

### 6th Matrix
data$f6 = ifelse(data$`Vehicle Daily Status`== "6",1,NA)
f6 = dcast(data[,c('Date','Vehicle ID','f6')], `Vehicle ID` ~ Date, fun.aggregate = f.agg)
f6 = data.matrix(f6[,2:ncol(f6)])
f6Color <- data.frame(x = c(0,1), y = c("#3391d5", "#3391d5"))
colnames(f6Color) <- NULL

### 7th Matrix
data$f7 = ifelse(data$`Vehicle Daily Status`== "7",1,NA)
f7 = dcast(data[,c('Date','Vehicle ID','f7')], `Vehicle ID` ~ Date, fun.aggregate = f.agg)
f7 = data.matrix(f7[,2:ncol(f7)])
f7Color <- data.frame(x = c(0,1), y = c("#ffaecf", "#ffaecf"))
colnames(f7Color) <- NULL

### 8th Matrix
data$f8 = ifelse(data$`Vehicle Daily Status`== "8",1,NA)
f8 = dcast(data[,c('Date','Vehicle ID','f8')], `Vehicle ID` ~ Date, fun.aggregate = f.agg)
f8 = data.matrix(f8[,2:ncol(f8)])
f8Color <- data.frame(x = c(0,1), y = c("#a49f9e", "#a49f9e"))
colnames(f8Color) <- NULL

### 9th Matrix
data$f9 = ifelse(data$`Vehicle Daily Status`== "9",1,NA)
f9 = dcast(data[,c('Date','Vehicle ID','f9')], `Vehicle ID` ~ Date, fun.aggregate = f.agg)
f9 = data.matrix(f9[,2:ncol(f9)])
f9Color <- data.frame(x = c(0,1), y = c("#4b4850", "#4b4850"))
colnames(f9Color) <- NULL
  
#Styling X, Y
x <- list(
  title = "",
  color = 'black',
  showgrid = FALSE
)
y <- list(
  title = "",
  color = 'black',
  showgrid = FALSE
)

#Plot_ly func to plot heatmap: X=Date, Y=Vehicle Id, showscale=F remove color legend, hoverinfo='x+y' limit hover text
plot_ly(type='heatmap',data, x=~unique(Date),y = ~(data$`Vehicle ID`),
        showscale = F, hoverinfo = 'x+y'
) %>% add_trace( #add_trace to add each matrix layer
  z = f1, #z: fill in matrix 
  colorscale = f1Color 
) %>% add_trace(
  z = f2,
  colorscale = f2Color
) %>% add_trace(
  z = f3,
  colorscale = f3Color
) %>% add_trace(
  z = f4,
  colorscale = f4Color
) %>% add_trace(
  z = f5,
  colorscale = f5Color
) %>% add_trace(
  z = f6,
  colorscale = f6Color
) %>% add_trace(
  z = f7,
  colorscale = f7Color
) %>% add_trace(
  z = f8,
  colorscale = f8Color
) %>% add_trace(
  z = f9,
  colorscale = f9Color
) %>% layout(paper_bgcolor='#ffffff',plot_bgcolor='#ffffff',xaxis = x, yaxis = y) #Add styling

