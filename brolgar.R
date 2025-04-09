key_slope(wages, ln_wages ~ xp)

wages_slope <- key_slope(wages, ln_wages ~ xp) %>%
  left_join(wages, by = "id")

library(gghighlight)

wages_slope %>%
  as_tibble() %>%
  ggplot(aes(x = xp, y = ln_wages, group = id)) +
  geom_line() +
  gghighlight(.slope_xp < 0)

summary(wages_slope$.slope_xp)

wages_slope %>%
  keys_near(key = id, var = .slope_xp)

wages_slope %>%
  keys_near(key = id, var = .slope_xp) %>%
  left_join(wages, by = "id") %>%
  ggplot(aes(x = xp, y = ln_wages, group = id, colour = stat)) +
  geom_line()

# You can read more about `keys_near()` in the [Identifying interesting observations](https://brolgar.njtierney.com/articles/id-interesting-obs.html) vignette.
