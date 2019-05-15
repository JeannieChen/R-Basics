library(ggplot2)
library(RColorBrewer)
library(plotly)
library(reshape2)

x_flag=as.vector(unique(data$flag)) #distinct flags in current dataset
colorset = c('#bafcd4','#bafcd4','#73C072','#73C072','#007E36','#007E36','#D00000','#D00000',
             '#f9ab45','#f9ab45','#0093D1','#0093D1','#525453','#525453','#000000','#000000') #define colorset for all distinct flags (2 * # of distinct flags)
             
s = as.integer(setdiff(c("1","2","3","4","5","6","7","9"), x_flag)) #find flags that are missing from pre-defined flags
for(i in 1:length(s)){
  if(s[i] == '9'){ colorset[c(((s[i]-1)*2-1):((s[i]-1)*2))] = NA }
  else{colorset[c((s[i]*2-1):(s[i]*2))] = NA}
} #replace missing flag value with NA

new_colorset = as.vector(na.omit(colorset)) #remove NA values from flag vector


num_s = length(unique(data$flag)) #find number of distinct flags
ct = cut(1:10,seq(from = 0, to = 1, by = 1/num_s), include.lowest = T) #split interval [0,1] into num_s sub-intervals
seg = strsplit(levels(ct), '[^-0-9.]+') #clean the ouput, convert it into a vector
seg = as.vector(unlist(seg))
seg = seg[seg != ""]

colorScale <- data.frame(z= seg,col=new_colorset) 
#define a colorScale dataframe that has segment between [0,1] and corresponding colorset

tick_seq = c()
for(j in 1:(length(seg)/2)){
  tick_seq[j] = (as.numeric(seg[j*2-1]) + as.numeric(seg[j*2]) )/2 
} #define tickval vector - vector of mean values of each two elements in seg

temp = dcast(data[,1:3], Vehicle_ID ~ TODATE) #reshape data - row values under TODATE become columns
temp_m = data.matrix(temp[,2:ncol(temp)]) #convert it into a matrix (exclude the 1st column Vehicle_ID)
temp_m = temp_m[,as.Date(colnames(temp_m)) %in% data$TODATE] #check date columns are within range


x <- list(
  title = "",
  color = '#ffffff'
)
y <- list(
  title = "",
  color = '#ffffff'
)

plot_ly(data, x=~unique(TODATE),y=~unique(Vehicle_ID),
        z=temp_m, type='heatmap', showscale=F, colorscale=colorScale
          #,hoverinfo = "x+y"
          #,text = ~paste('Date: ',unique(data$TODATE))
       ,colorbar=list(ypad = 30, tickvals=tick_seq, ticktext=sort(x_flag))
       ) %>% layout(paper_bgcolor='black',plot_bgcolor='black',xaxis = x, yaxis = y)
