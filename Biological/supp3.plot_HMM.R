library(ggplot2)

infile = commandArgs(TRUE)[1]
outfile = commandArgs(TRUE)[2]

d = read.delim(infile, check.names = FALSE)

names(d)[1:2] = c("state", "Genome %")
d = d[d$state != "Base", ]

state_order = d$state

x = data.frame(
  state  = rep(d$state, times = ncol(d) - 2),
  sample = rep(names(d)[-(1:2)], each = nrow(d)),
  FE     = as.numeric(unlist(d[-(1:2)]))
)

x$sample = sub(".*00_0_0.001.*",   "0-0.001",   x$sample)
x$sample = sub(".*01_0.001_0.1.*", "0.001-0.1", x$sample)
x$sample = sub(".*02_0.1_0.5.*",   "0.1-0.5",   x$sample)
x$sample = sub(".*03_0.5_0.9.*",   "0.5-0.9",   x$sample)
x$sample = sub(".*04_0.9_0.999.*", "0.9-0.999", x$sample)
x$sample = sub(".*05_0.999_1.*",   "0.999-1",   x$sample)

sample_order = c(
  "0-0.001",
  "0.001-0.1",
  "0.1-0.5",
  "0.5-0.9",
  "0.9-0.999",
  "0.999-1"
)

x$sample = factor(x$sample, levels = sample_order)
x$state  = factor(x$state, levels = rev(state_order))

x$FE_fraction = ave(
  x$FE,
  x$sample,
  FUN = function(z) z / sum(z, na.rm = TRUE)
)

p = ggplot(x, aes(sample, state, fill = FE_fraction)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "blue") +
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_text(angle = 35, hjust = 1),
    plot.title = element_text(hjust = 0.5)
  ) +
  labs(
    x = "G4 confidence interval",
    y = "ChromHMM state",
    fill = "FE fraction",
    title = "E123 K562 hg19 18-state ChromHMM"
  )

ggsave(outfile, p, width = 8, height = 6, dpi = 300)