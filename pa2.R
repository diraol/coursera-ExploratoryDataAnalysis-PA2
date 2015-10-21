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
barplot(plot1_data$emissions, plot1_data$year, names.arg=plot1_data$year)

# Based on the plotted graph, we can say that the Emissions of PM2.5 on US,
# from all sources, have decreased from 1999 to 2008.


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
barplot(plot2_data$emissions, plot2_data$year, names.arg=plot2_data$year)

# Based on the plotted graph, we can say that the Emissions of PM2.5 on US,
# from all sources, have decreased from 1999 to 2008.