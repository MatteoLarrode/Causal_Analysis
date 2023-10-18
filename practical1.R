# Week 1: Statistical Preliminaries ---------
library(tidyverse)

fishdata <- read_csv("data/fishdata.csv")

# a) ----
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

# c) ----
# Differences in means in b) is likely to be biased by omitted variable bias.
# Being to a previous colony, and gdp are examples of such omitted variables

# d) ----
# Conduct a t-test for the difference in means in (b) using R’s t.test() function. 
# Is the difference statistically significant?
t.test(fishdata[fishdata$MUSLIM == 1,]$FHREVERS, fishdata[fishdata$MUSLIM == 0,]$FHREVERS)
# The difference is statistically significant at any significance level,
# because the t-statistic is -9.63 and the p-value is extremely close to zero

# e) ----
# Conduct the t-test again, this time coding it by hand. 
# Confirm that your answer is identical to (d)
d <- mean(fishdata[fishdata$MUSLIM == 1,]$FHREVERS) - mean(fishdata[fishdata$MUSLIM == 0,]$FHREVERS)

se <- sqrt(
  var(fishdata[fishdata$MUSLIM == 1,]$FHREVERS) / length(fishdata[fishdata$MUSLIM == 1,]$FHREVERS) +
  var(fishdata[fishdata$MUSLIM == 0,]$FHREVERS) / length(fishdata[fishdata$MUSLIM == 0,]$FHREVERS)
)

d/se

#f) ----
# i) The percentage of Muslim countries that are former British colonies
length(fishdata$MUSLIM[fishdata$BRITCOL==1 & fishdata$MUSLIM==1]) / sum(fishdata$MUSLIM)

# ii) The percentage of non-Muslim countries that are former British colonies


# iii) The correlation between being a former British colony and Freedom House 
# score, controlling for being Muslim


# Use these results to explain the impact that controlling for BRITCOL has on the estimated effect of MUSLIM