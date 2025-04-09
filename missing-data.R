vec_num <- set_prop_miss(vec_num, 0.4)
vec_int <- set_prop_miss(vec_int, 0.4)
vec_fct <- set_prop_miss(vec_fct, 0.4)

vec_num <- rnorm(10)
vec_int <- rpois(10, 5)
vec_fct <- factor(LETTERS[1:10])


vec_num


impute_fixed(vec_num, -999)

impute_fixed(vec_int, -999)
