# Main R code file

# code taken from https://shirinsplayground.netlify.com/2018/07/explaining_ml_models_code_caret_iml/

# things that had to be installed first
# install.packages("tidyverse","gridExtra","ggridges","ggthemes")
# install.packages("iml","breakDown","DALEX")


# Zeroth section ----
# clean up

rm(list=ls(all=TRUE))

# setwd
# dirname(sys.frame(1)$ofile)

# First section -----

library(ggplot2) # manually load this first to get the right version

# data wrangling
# remotes::install_github("RcppCore/Rcpp")
# 
library(tidyverse) # already this needs Rcpp 0.12.15 or higher...
library(readr)

# ml
library(caret) # manually installed

# plotting
library(gridExtra)
library(grid)
library(ggridges)
library(ggthemes)
theme_set(theme_minimal())

# explaining models
# https://github.com/christophM/iml
# install.packages("iml", dependencies=TRUE, repos="https://github.com/christophM/iml")
# remotes::install_github("christophM/iml") # this worked in the end
# devtools::install_github("christophM/iml") # this worked in the end
library(iml)

# https://pbiecek.github.io/breakDown/
# remotes::install_github("pbiecek/breakDown")
# devtools::install_github("pbiecek/breakDown")
library(breakDown)

# https://pbiecek.github.io/DALEX/
# dependencies

# factorMerger needs Rcpp 12.15, on MRAN it is 12.12, on CRAN it is 12.18
# remotes::install_github("RcppCore/Rcpp") # from https://github.com/RcppCore/Rcpp
# install.packages("Rcpp", rep = "https://github.com/RcppCore/Rcpp") # had to manually download the .tar file for Rcpp 0.12.18....
# devtools::install_github("MI2DataLab/factorMerger")
# DALEX package
# devtools::install_github("pbiecek/DALEX") # had to install the devtools package, too

library(DALEX)

# Second section -----

# loading data
wine_data <- read.csv("winequality-red.csv") %>% # change _ to .
    mutate(quality = as.factor(ifelse(quality < 6, "qual_low", "qual_high"))) 

# checking out the data
colnames(wine_data) <- gsub(" ", "_", colnames(wine_data))
colnames(wine_data) <- gsub("\\.", "_", colnames(wine_data))
# gsub(".", "", colnames(wine_data))
glimpse(wine_data)

# Third Section, exploratory phase -----
# Exploratory data analysis
p1 <- wine_data %>%
    ggplot(aes(x = quality, fill = quality)) +
    geom_bar(alpha = 0.8) +
    scale_fill_tableau() +
    guides(fill = FALSE)
p2 <- wine_data %>%
    gather(x, y, fixed_acidity:alcohol) %>%
    ggplot(aes(x = y, y = quality, color = quality, fill = quality)) +
    facet_wrap( ~ x, scale = "free", ncol = 3) +
    scale_fill_tableau() +
    scale_color_tableau() +
    geom_density_ridges(alpha = 0.8) +
    guides(fill = FALSE, color = FALSE)

# playing around here 
p3 <- wine_data %>% 
    ggplot(aes(x = quality, fill = quality)) + # defines the bars, apparently it assumes counting here
    geom_bar(alpha = 0.8) + # makes the geometrical bars
    scale_fill_tableau() + # and this seems to define colours
    guides(fill = FALSE) # removes the legend

grid.arrange(p1, p2,p3, ncol = 3, widths = c(0.2, 0.6, 0.2))
