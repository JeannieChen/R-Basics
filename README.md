## Introduction

R-Basic includes some of my daily tasks using R.

### Content Category
- Functions for data cleanse, transformation (1)
- Statistical models for analysis, prediction (2)
- ODBC Connection (3)
- Data visualization (4)
- Other fun stuff (5)

### List

1. CHUNK-FIL-A.R (1): Function that will take a large CSV file in location X, split it up Y number of times, then write it back in Z location with N[i] as the file name, and CN as the column names.

2. RODBC template.R (3): ODBC connection setup template. Common functions to execute queries and retrieve datdaset.

3. TF-IDF.R (2): Function that implements topic modeling by simply giving text dataset, target column, grouping tags and plot(boolean value. If TRUE output plots of analysis).

4. Ames (STAT 4620 Final Project) (2): The main question of interest in this dataset is How do home features add up to its price tag? This analysis involves forming a predictive model for the response variable, SalePrice, as a function of the 79 predictor variables. The 79 predictor variables are described in the file data description.txt.
- 4620_project.Rmd: dataset EDA
- 4620_model.R: Propose  a  predictive  model  for  the  response  variable  using the train.dat training data and provide evidence of the appropriateness of the model

5. LDA.R (2): Function that implements LDA (Latent Dirichlet Allocation) models: Top_terms_by_topic_LDA(textContent, number_of_topics). Output analysis of topics in different plots altogether.

6. geom_tile-in-plot_ly.R (1)(4): Supplementation of geom_tile() function using 'heatmap' in plot_ly. Define colorScale(seg,colorset) and tickvals based on flags in input dataset (live data). Reshape data and convert it into matrix. Define discrete color bar for heatmap in plot_ly. Output: a plot_ly object with same features as using geom_tile() from ggplot2. Reduce rendering time significantly.

7. Lof-file_Clean.R (1): Given the path to the folder and process each log file each time. Scripts to extract/truncate strings, etc.
