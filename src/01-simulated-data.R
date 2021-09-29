# libraries -----
library(devtools)
library(here)
library(purrr)
library(dplyr)
library(janitor)

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

# data cleaning ----------------------------------------------------------------

phvi_means <- phvi %>%
  janitor::clean_names() %>%
  rename(
    pct_wet_sa  = pct_wet_of_surface_area_acting_as_a_free_water_exchanger,
    min_for_deg_c  = minimum_foraging_temperature_degrees_celcius,
    max_temp_act_deg_c = maximum_temperature_at_which_activity_occurs_degrees_c,
    min_b_deg_c = minimum_basking_temperature_to_the_nearest_degree_degrees_c,
    min_temp_retr = minimum_temperature_it_will_leave_retreat_to_bask_the_nearest_degree_degrees_celcius,
    min_crit_therm = critical_thermal_minimum_degrees_c,
    max_crit_therm = critical_thermal_maximum_degrees_c,
    temp_pref = preferreed_temperature_degrees_c, 
    min_depth = min_depth_node, 
    max_depth = max_depth_node
  ) %>%
  group_by(site, sex) %>%
  summarize(
    wwg      = mean(wet_weight_grams), 
    sad      = mean(solar_absorbtivity_dec),
    pct_wet  = mean(pct_wet_sa),
    min_for  = mean(min_for_deg_c),
    max_for  = mean(max_temp_act_deg_c),
    min_bask = mean(min_b_deg_c),
    min_retr = mean(min_temp_retr),
    min_ct = mean(min_crit_therm),
    max_ct = mean(max_crit_therm),
    t_pref = mean(temp_pref),
    min_depth = mean(min_depth),
    max_depth = mean(max_depth),
    reps = n()
  )

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



