penguins <- read_csv(
  "/Users/nick/github/njtierney/reprex-essentials/data/penguins.csv"
)

library(tidyverse)

flipper_bill <- ggplot(
  penguins,
  aes(x = flipper_length_mm, y = bill_length_mm, colour = species)
) +
  geom_point() +
  scale_color_discrete_qualitative()
