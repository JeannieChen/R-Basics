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
- 4620_model.R: Propose  a  predictive  model  for  the  response  variable  using the train.dat training data and provide evidence of the appropriateness of your model
