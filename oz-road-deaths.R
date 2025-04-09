

### Indemnity Statement:

The Bureau of Infrastructure, Transport and Regional Economics has taken due care in preparing this information. However, noting that data have been provided by third parties, the Commonwealth gives no warranty as to the accuracy, reliability, fitness for purpose, or otherwise of the information.

Copyright

© Commonwealth of Australia, 2024

This work is copyright and the data contained in this publication should not be reproduced or used in any form without acknowledgement.

## Import data from the BITRE website into R

```{r}
#| label: load-library
#| message: false
#| warning: false
#| cache: true
library(ozroaddeaths)
library(dplyr)
library(ggplot2)
library(lubridate)
#library(ggridges)
```

```{r}
#| label: load-data

crashes <- oz_road_fatal_crash() 
fatalities <- oz_road_fatalities()

```

## Variables available

### Crashes

```{r}
#| results: asis
knitr::kable(head(crashes))
```

### Fatalities

```{r}
#| label: fatalities first look
#| results: asis
knitr::kable(head(fatalities))
```

### Plot crashes by year

```{r}
#| label: crash-plot-by-year
#| width: 10
crash_plot <- ggplot(crashes,
                     aes(x = year)) +
  geom_line(stat = "count") +
  theme_minimal() +
  labs(title = "Annual number of fatal car accidents per year")

crash_plot

```


### Plot crashes by year and state

```{r}
#| label: crash-plot-by-year-and-state
#| width: 10

crash_plot +
  scale_y_continuous(trans = "log2") +
  facet_wrap(~state) +
  labs(title = "Annual number of fatal car accidents per year and state",
       subtitle = "log2 scale" )

```

### Fatalities by year

```{r}
#| label: fatalities-plot-by-year
#| width: 10

fatality_plot <- fatalities %>%
  mutate(year = lubridate::year(date_time)) %>%
  ggplot(aes(x =  year)) +
  geom_line(stat = "count") +
  theme_minimal() +
  ggtitle("Annual number of road fatalities")

fatality_plot

```

```{r}
#| label: fatalities-plot-by-age
#| width: 10

fatality_plot <- fatalities %>%
  filter(gender != "Unspecified") %>%
  mutate(year = lubridate::year(date_time)) %>%
  ggplot(aes(x = age, 
             fill = gender )) +
  geom_density() +
  facet_wrap(~gender) +
  theme_minimal() +
  ggtitle("Distribution of road fatalities by age 1989 to 2024")

fatality_plot

```



