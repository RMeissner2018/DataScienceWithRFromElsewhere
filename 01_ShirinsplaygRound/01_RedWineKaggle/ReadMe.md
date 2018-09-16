Trying out the example 
"https://shirinsplayground.netlify.com/2018/07/explaining_ml_models_code_caret_iml/" 
based on the kaggle Red Wine Quality data set "https://www.kaggle.com/uciml/red-wine-
quality-cortez-et-al-2009".

# Motivation
- Learn how to do data science and machine learning based on an actual (and 
potentially well explained) example.
- Use a kaggle data set to get familiar with kaggle, the way it presents data and more

# More on this example
- Has been documented here, too: https://www.kaggle.com/meepbobeep/intro-to-
regression-and-classification-in-r
- Kaggle gives some informations and what one could do, too

# First Section
Installing the packages took me frustratingly long, especially as I had not the most 
up to date version of RStudio installed, packages were installed in the wrong folder 
(refer to .libPaths()) and apparently Rcpp and some other packages mess up each other. 
There are ways to solve this, though. The devtools package came in hand quite nicely 
during the installation process to install packages from GitHub directly.

# Second section
1.Loading the data. Apparently the data set is slightly different from the example 
because colnames has "." in it, instead of spaces. Might be caused because I am 
calling read.csv() and not read_csv(). By using gsub() with "\\." as an indication of 
the period "." and not just any character, this is resolved.
2. What troubles me the most here is the %>% operator. It seems to apply the data on 
the left side to the functions on the right. More I cannot say yet. Plotting the first 
graphs does not work if this is not used

Findings
- Low quality wines have on average less alcohol, but may have morge sulfur dioxides 
and volatile acidity
- The average pH value of wine is below 3.5 - a potent acid.
- The rest seems very similar

# Misc
1.  cheat sheet: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet