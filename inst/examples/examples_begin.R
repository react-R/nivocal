library(nivocal)

# fake data of 500 records/days starting 2017-03-15
df <- data.frame(
  day = seq.Date(
    from = as.Date("2017-03-15"),
    length.out = 500,
    by = "days"
  ),
  value = round(runif(500)*1000, 0)
)

nivocal(df)

nivocal(
  df,
  direction = "vertical",
  colors = RColorBrewer::brewer.pal(n=9, "Blues")
)
