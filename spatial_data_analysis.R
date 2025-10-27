# load libraries
library(tidyverse)
library(sf)
library(mapview)

# load the fish data
fishdat <- read_csv('data/fishdat.csv')

# load the station data
statloc <- read_csv('data/statloc.csv')

# load the sgdat shapefile
sgdat <- st_read('data/sgdat.shp')

methods(class = 'sf')

sgdat <- st_read('data/sgdat.shp', quiet = T)
sgdat

str(statloc)

sfstatloc <- st_as_sf(statloc, coords = c('Longitude', 'Latitude'), crs = 4326)
sfstatloc

# Join the data
alldat <- left_join(fishdat, statloc, by = 'Reference')

# create spatial data object
alldat <- st_as_sf(alldat, coords = c('Longitude', 'Latitude'), crs = 4326)

# examine the sf object
alldat
str(alldat)

# check crs
st_crs(alldat)

# verify the polygon and point data have the same crs
st_crs(sgdat)
st_crs(alldat)

alldatutm <- alldat |> 
  st_transform(crs = '+proj=utm +zone=17 +datum=NAD83 +units=m +no_defs')
st_crs(alldatutm)

plot(alldat)
plot(sgdat)

plot(alldat$geometry)
plot(sgdat$geometry)

filt_dat <- alldat |> 
  filter(yr == 2016)
plot(filt_dat$geometry)

fish_crop <- filt_dat[sgdat, ]
plot(fish_crop$geometry)
fish_crop

fish_int <- st_intersection(filt_dat, sgdat)
plot(fish_int$geometry)
fish_int

fish_cnt <- fish_int |>
  group_by(FLUCCS) |> 
  summarise(
    Count = sum(Pinfish)
  ) 
fish_cnt

ggplot(fish_cnt, aes(x = FLUCCS, y = Count)) + 
  geom_bar(stat = 'identity')

# use ggplot with sf objects
ggplot() + 
  geom_sf(data = sgdat, aes(fill = FLUCCS)) + 
  geom_sf(data = fish_int) 

mapview(sgdat, zcol = 'FLUCCS') +
  mapview(fish_int)

# filter and intersect data
tomap <- alldat |> 
  filter(yr == 2016) |> 
  st_intersection(sgdat)

# make map
mapview(tomap, zcol = 'Pinfish')
mapview(tomap, zcol = 'Bluefish')

# join maps
mapview(sgdat, zcol = 'FLUCCS') + mapview(tomap, zcol = 'Pinfish')
