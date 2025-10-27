# # install
# install.packages('tidyverse')

library(tidyverse)

# load the fish data
fishdat <- read_csv('data/fishdat.csv')

# load the station data
statloc <- read_csv('data/statloc.csv')

# join the two 
joindat <- left_join(fishdat, statloc, by = 'Reference')
head(joindat)

# load the fish data
fishdat <- read_csv('data/fishdat.csv')

# load the station data
statloc <- read_csv('data/statloc.csv')

# wrangle before join
joindat <- fishdat |> 
  select(Reference, Sampling_Date, Gear, `Common Snook`) |> 
  filter(Gear == 20) 

dim(joindat)

# full join
joindat <- joindat |> 
  full_join(statloc, by = 'Reference')

dim(joindat)

table1
table2
table3

# Spread across two tibbles
table4a  # cases
table4b  # population

table4a

table4a |>
  pivot_longer(c('1999', '2000'), names_to = "year", values_to = "cases")

table2

pivot_wider(table2, names_from = 'type', values_from = 'count')

# check dimensions, structure
dim(fishdat)
str(fishdat)

# convert fishdat to long format
longdat <- fishdat |>
  pivot_longer(c('Bluefish', 'Common Snook', 'Mullets', 'Pinfish', 'Red Drum', 'Sand Seatrout'), names_to = 'Species', values_to = 'Count')

# check dimensions, structure
dim(longdat)
str(longdat)

head(longdat)

by_spp <- summarize(longdat, totals = sum(Count), .by = Species)
by_spp

by_spp_gear <- summarize(longdat, totals = sum(Count), .by = c(Gear, Species))
by_spp_gear

more_sums <- summarize(longdat, 
    n = n(),
    min_count = min(Count),
    max_count = max(Count),
    total = sum(Count), 
    .by = Species
  )
more_sums

x <- c(1, 2, NA, 4)
mean(x)
mean(x, na.rm = T)

anyNA(x)

sumdat <- longdat |>
  filter(Gear == 20 & Species == 'Pinfish') |> 
  summarize(
    ave = mean(Count), 
    .by = Reference
  ) |> 
  arrange(-ave)
sumdat
