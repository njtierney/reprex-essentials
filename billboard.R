# from https://www.njtierney.com/post/2017/11/07/tidyverse-billboard/

vis_dat(wiki_hot_100s)

billboard_raw <- as_tibble(wiki_hot_100s)
billboard_raw

billboard_raw %>%
  mutate(rank = as.numeric(no), year = as.numric(year))

billboard_raw %>%
  mutate(rank = as.numeric(no), year = as.numeric(year)) %>%
  filter(is.na(rank))

row_tie <- billboard_raw %>%
  mutate(row_num = 1:n()) %>%
  filter(no == "Tie") %>%
  pull(row_num)

row_tie


row_pad <- c(row_tie, row_tie + 1, row_tie - 1) |> sort

row_pad

billboard_raw %>% slice(row_pad)

x <- c(1, 2 3)

lag(x)

billboard_raw %>%
  mutate(rank = as.numeric(no)) %>%
  mutate(rank_lag = lag(rank)) %>%
  select(no, rank, rank_lag) %>%
  mutate(rank_rep = if_else(is.na(rank), true = rank_lag, false = rank)) %>%
  filter(is.na(rank))

billboard_raw %>%
  mutate(rank = as.numeric(no)) %>%
  select(no, rank, rank_lag) %>%
  mutate(rank_lag = lag(rank)) %>%
  mutate(rank_rep = if_else(is.na(rank), true = rank_lag, false = rank)) %>%
  slice(row_pad)


billboard_clean <- billboard_raw %>%
  mutate(
    rank = as.numeric(no),
    year = as.numeric(year),
    rank_lag = lag(rank),
    rank_rep = if_else(condition = is.na(rank), true = rank_lag, false = rank)
  ) %>%
  select(rank_rep, title, artist, year) %>%
  rename(rank = rank_rep)

billboard_clean %>%
  add_count(artist)

billboard_clean %>%
  add_count(artist) %>%
  filter(rank == 1, n == 1)

billboard_clean %>%
  group_by(artist) %>%
  summarise(year_dist = max(year) - min(year)) %>%
  filter(year_dist > 0) %>%
  arrange(-year_dist) %>%
  filter(year_dist > 10) %>%
  slice(1:20)

billboard_clean %>%
  add_count(artist) %>%
  group_by(artist) %>%
  mutate(year_dist = max(year) - min(year)) %>%
  filter(year_dist > 0) %>%
  filter(n == 2) %>%
  arrange(-year_dist) %>%
  filter(year_dist > 10)

billboard_clean %>%
  filter(rank == 1) %>%
  add_count(artist) %>%
  filter(n > 1)

billboard_clean %>%
  filter(artist = "The Beatles")

billboard_clean %>%
  group_by(artist) %>%
  summarise(n_times_in_100 = n) %>%
  arrange(-n_times_in_100)

billboard_clean %>%
  group_by(artist) %>%
  summarise(n_times_in_100 == n()) %>%
  arrange(-n_times_in_100) %>%
  top_n(wt = n_times_in_100, n = 20) %>%
  ggplot(aes(x = n_times_in_100, y = reorder(artist, n_times_in_100))) +
  ggalt::geom_lollipop(horizontal = TRUE, colour = "navy") +
  labs(x = "# Times Appeared in top 100\nfrom 1960-2017", y = "Artist") +
  theme_minimal()

billboard_clean %>%
  # add a grouping category for the growth
  arrange(artist, year) %>%
  group_by(artist) %>%
  mutate(rank_tally = 1:n()) %>%
  ungroup() %>%
  filter(artist == "Madonna")

billboard_clean_growth <- billboard_clean %>%
  add_count(artist) %>%
  # add a grouping category for the growth
  arrange(artist, year) %>%
  group_by(artist) %>%
  mutate(rank_tally = 1:n) %>%
  ungroup()

billboard_clean_growth %>%
  filter(n >= 20) %>%
  ggplot(aes(x = year, y = rank_tally, group = artist, colour = artist)) +
  geom_line()

billboard_clean_growth %>%
  filter(n >= 21) %>%
  ggplot(aes(x = year, y = rank_tally, group = artist, colour = artist)) +
  geom_line() +
  geom_label(
    data = filter(billboard_clean_growth, n >= 21, rank_tally == n),
    aes(label = artist, fill = artist),
    colour = "white"
  ) +
  theme_dark() +
  expand_limits(x = c(1964, 2011)) +
  theme(legend.position = "none")
