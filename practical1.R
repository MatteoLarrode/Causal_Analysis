# Week 1: Statistical Preliminaries ---------
library(tidyverse)


# a) ----

fishdata <- read_csv("data/fishdata.csv")

# i) How many countries are predominantly Muslim?
nrow(fishdata[fishdata$MUSLIM == 1, ])

# ii) What percentage of countries are predominantly Muslim?
nrow(fishdata[fishdata$MUSLIM == 1, ]) / nrow(fishdata) * 100

# iii) How many countries have GDP in 1990 of above 3.0?
nrow(fishdata[fishdata$GDP90LGN > 3,])

# iv) How many countries are both Muslim and a former British colony?
fishdata |> 
  filter(MUSLIM == 1 & BRITCOL == 1) |> 
  nrow()

# v) How many countries have either average economic growth from 1975-98 of above 0.6% or GDP in 1990 of above 2.5?
fishdata |> 
  filter(GRW7598P > .6 | GDP90LGN > 2.5) |> 
  nrow()

# vi) Create a new dataset consisting only of countries that are both Muslim and a member of OPEC
muslim_OPEC <- fishdata |> 
  filter(MUSLIM == 1 & OPEC == 1)

# b) ----
# What is the difference in mean Freedom House score between Muslim and Non-Muslim countries? 
# Calculate it both by hand and using a regression, verifying that your answers are identical.

# by hand
mean(fishdata[fishdata$MUSLIM == 0,]$FHREVERS) - mean(fishdata[fishdata$MUSLIM == 1,]$FHREVERS)
# by regression
summary(lm(FHREVERS ~ MUSLIM == 0, fishdata))

# differences in mean score are equal because dependent variable is binary


