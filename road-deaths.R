## Variables available

kable(head(crashes))

kable(head(fatalities))

crash_plot <- ggplot(crashes, aes(x = year)) +
  geom_line(stat = "count") +
  theme_minimal() +
  labs(title = "Annual number of fatal car accidents per year")

crashes <- oz_road_fatal_crash()
fatalities <- oz_road_fatalities()
