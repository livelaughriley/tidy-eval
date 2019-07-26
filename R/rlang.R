library(dplyr)


# number of arguments is known -----------------------------------------------

starwars %>% 
  group_by(gender) %>% 
  summarise(
    mass_max = max(mass, na.rm = TRUE)
  )

## doesn't work 
max_by_bad <- function(data, var, by) {
  data %>% 
    group_by(by) %>% 
    summarise(maximum = max(var, na.rm = TRUE))
}
starwars %>% max_by_bad(var = mass, by = gender)


## works
max_by_good <- function(data, var, by) {
  data %>% 
    group_by(!! enquo(by)) %>% 
    summarise(maximum = max(!! enquo(var), na.rm = TRUE))
}
starwars %>% max_by_good(var = mass, by = gender)


## also works
max_by_better <- function(data, var, by) {
  data %>% 
    group_by( {{by}} ) %>% 
    summarise(maximum = max( {{var}}, na.rm = TRUE))
}
starwars %>% max_by_better(var = mass, by = gender)


# unknown (multiple) arguments --------------------------------------------

## numeric arguments
summarise_by <- function(data, ..., by) {
  data %>% 
    group_by( {{by}} ) %>% 
    summarise(...)
}
starwars %>% summarise_by(
  average = mean(height, na.rm = TRUE),
  maximum = max(height, na.rm = TRUE),
  by = gender
)


## string arguments
max_by <- function(data, var, by) {
  data %>% 
    group_by(.data[[by]]) %>% 
    summarise(maximum = max(.data[[var]], na.rm = TRUE))
}
starwars %>% max_by("height", by = "gender")
