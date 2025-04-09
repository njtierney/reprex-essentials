# doing some color manipulation
# from https://www.njtierney.com/post/2020/10/15/assess-colour/

library(colorspace)
hcl_cold <- qualitative_hcl(
  n = 3,
  palette = "Cold"
)

library(prismatic)
check_color_blindness(hcl_cold)

hcl_pals_q <- hcl_palettes(type = "qualitative")
hcl_pals_q

qual_cvd <- function(palette = "Pastel1", alpha = 0.67) {
  qualitative_hcl(n = 3, alpha = alpha, palette = palette) %>%
    check_color_blindness()
}

qual_cvd("Dark 2")

qual_cvd("Dark 3")

qual_cvd <- function(palette = "Pastel1", alpha = 0.67) {
  qualitative_hcl(n = 3, alpha = alpha, palette = palette) |>
    check_color_blindness()
}

qualitative_hcl(n = 3, alpha = 0.67, palette = "Cold") %>%
  demoplot(type = "map")

qualitative_hcl(n = 3, alpha = 0.67, palette = "Cold") |>
  protan()

qual_return_cvd <- function(palette = "Cold", alpha = 0.67) {
  pals <- qualitative_hcl(n = 3, alpha = alpha, palette = palette)
  pals_protan <- protan(pals)
  pals_deutan <- deutan(pals)
  pals_tritan <- tritan(pals)

  return(list(
    protan = pals_protan,
    deutan = pals_deutan,
    tritan = pals_tritan
  ))
}
qual_return_cvd()

qual_return_cvd() |> walk(demoplot)

qual_return_cvd(palette = "Dark 3") |> walk(demoplot)


flipper_bill <- ggplot(
  penguins,
  aes(x = flipper_length_mm, y = bill_length_mm, colour = species)
) +
  geom_point() +
  scale_color_discrete_qualitative()

cvd_grid(fig)
