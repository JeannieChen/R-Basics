## Introduction

R-Basic includes some of my daily tasks using R.

### List

1. CHUNK-FIL-A.R: Function that will take a large CSV file in location X, split it up Y number of times, then write it back in Z location with N[i] as the file name, and CN as the column names.

2. RODBC template.R: ODBC connection setup template. Common functions to execute queries and retrieve datdaset.

3. TF-IDF.R: Function that implements topic modeling by simply giving text dataset, target column, grouping tags and plot(boolean value. If TRUE output plots of analysis).

4. LDA.R: Function that implements LDA (Latent Dirichlet Allocation) models: Top_terms_by_topic_LDA(textContent, number_of_topics). Output analysis of topics in different plots altogether.

5. geom_tile-in-plot_ly.R: Supplementation of geom_tile() function using 'heatmap' in plot_ly. Define colorScale(seg,colorset) and tickvals based on flags in input dataset (live data). Reshape data and convert it into matrix. Define discrete color bar for heatmap in plot_ly. Output: a plot_ly object with same features as using geom_tile() from ggplot2. Reduce rendering time significantly.

6. Log-file_Clean.R: Given the path to the folder and process each log file each time. Scripts to extract/truncate strings, etc.

7. Discrete_Custom_Color_Plot_ly_Heatmap.R: Assign discrete custom color based on a column of variable in the dataset then use plot_ly to build an interactive heatmap (alternative to geom_tile in ggplots/ggplotly).

8. convert_long_lat_to_country.R: Convert lat/long to Country name without using Google API
