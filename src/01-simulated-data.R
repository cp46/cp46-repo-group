# libraries -----
library(devtools)
library(here)
library(purrr)

# download NicheMapR from github repo
devtools::install_github('mrke/NicheMapR')
library(NicheMapR)

# global climate model ----

get.global.climate(
  folder = here("data", "raw")
  )

# global implementation of the microclimate model ----

longlat <- c(145.43, -17.13) 
nyears <- 1

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

