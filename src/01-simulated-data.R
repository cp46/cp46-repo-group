# libraries -----
library(devtools)
library(here)
library(purrr)

# download NicheMapR from github repo
devtools::install_github('mrke/NicheMapR')
library(NicheMapR)

# import the simulated data ----

# biological parameters for Phaulacridium vittatum 
# includes both female and male 
phvi <- read.csv(
  here("data", "raw", "phvi_params.csv")
)

# environmental parameters for each site
envs <- read.csv(
  here("data", "raw", "env_params.csv")
)

# download global climate model data-sets ----

get.global.climate(folder = here("data", "raw"))

# global implementation of the micro-climate model ----

# coordinates for tasmania 
longlat <- c(145.43, -17.13) 

# a single year
nyears <- 1

# get micro-climates!
micro <- NicheMapR::micro_global(
  loc = longlat, 
  soiltype = 10, 
  elev = 594, 
  runmoist = 1,
  nyears = nyears, 
  runshade = 0, 
  minshade = 0, 
  clearsky = 1, 
  run.gads =1, 
  IR = 0, 
  soilgrids = 0, 
  Usrhyt = 0.01, 
  slope = 0, 
  aspect = 0, 
  REFL = 0.15
  )



