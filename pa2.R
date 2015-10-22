# Copyright (C) 2015, Diego Rabatone Oliveira
#
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This code is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this code. If not, see <http://www.gnu.org/licenses/>.

# Setting current directory where data is stored
setwd("~/Cursos/coursera-exploratoryDataAnalysis/PA2")

# Download data from:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# and unzip it on the same folder where this code is.

# Setting local language to english instead of portguese:
Sys.setlocale("LC_TIME","C")

#### READING DATA ####
base_data <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")

#### PLOT 1 #####
# Question: Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? Using the base plotting system, make a plot showing
# the total PM2.5 emission from all sources for each of the years
# 1999, 2002, 2005, and 2008.

### Evaluating PM25 by year
# First load dplyr library to help with data
library('dplyr')

# Calculating the sum of emissions of PM25 by year
plot1_data <- base_data %>%
    # First select only Pollutant, Emissions and year columns
    select(Pollutant, Emissions, year) %>%
    # Now filter by Pollutant equal to PM25-PRI
    filter(Pollutant=="PM25-PRI") %>%
    # Grouping data by year
    group_by(year) %>%
    # Summarizing data by year as the sum of all data from that year
    summarise(emissions = sum(Emissions))

# Ploting the Emissions by year:
png(file="plot1.png")
barplot(plot1_data$emissions, plot1_data$year, names.arg=plot1_data$year,
        main="Emissions of PM2.5 from all sources, on US")
dev.off()

# Based on the plotted graph, we can say that the Emissions of PM2.5 on US,
# from all sources, have decreased from 1999 to 2008.

#################
#### PLOT 2 #####
# Question: Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system
# to make a plot answering this question.

### Evaluating PM25 by year in Baltimore City
# Calculating the sum of emissions of PM25 by year
plot2_data <- base_data %>%
    # First filter data to Baltimore (fips=='24510')
    filter(fips=="24510") %>%
    # Then select only Pollutant, Emissions and year columns
    select(Pollutant, Emissions, year) %>%
    # Now filter by Pollutant equal to PM25-PRI
    filter(Pollutant=="PM25-PRI") %>%
    # Grouping data by year
    group_by(year) %>%
    # Summarizing data by year as the sum of all data from that year
    summarise(emissions = sum(Emissions))

# Ploting the Emissions by year:
png(file="plot2.png")
barplot(plot2_data$emissions, plot2_data$year, names.arg=plot2_data$year,
        main="Emissions of PM2.5 from all sources, on Baltimore City")
dev.off()

# Based on the plotted graph, we can not say that the Emissions of PM2.5,
# from all sources, have decreased from 1999 to 2008 in Baltimore City.


#################
#### PLOT 3 #####
# Question: Of the four types of sources indicated by the type
# (point, nonpoint, onroad, nonroad) variable, which of these four sources
# have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2
# plotting system to make a plot answer this question.

# Loading ggplot library
library('ggplot2')

### Evaluating PM25 by year in Baltimore City
# Calculating the sum of emissions of PM25 by year
plot3_data <- base_data %>%
    # First filter data to Baltimore (fips=='24510')
    filter(fips=="24510") %>%
    # Then select only Pollutant, Emissions and year columns
    select(Pollutant, Emissions, year, type) %>%
    # Now filter by Pollutant equal to PM25-PRI
    filter(Pollutant=="PM25-PRI") %>%
    # Grouping data by type and year
    group_by(type, year) %>%
    # Summarizing data by year as the sum of all data from that year
    summarise(emissions = sum(Emissions))

# Ploting the Emissions by year:
png(file="plot3.png")
ggplot(plot3_data, aes(x=as.character(year), y=emissions)) +
    geom_bar(aes(fill=type), position="dodge", stat="identity") +
    facet_wrap(~type)
dev.off()

# Based on the plotted graph, the yearly emissions of NONPOINT,
# NON-ROAD and ON-ROAD has decreased between 1999 and 2008, while
# the yearly emissions of POINT has increased.
