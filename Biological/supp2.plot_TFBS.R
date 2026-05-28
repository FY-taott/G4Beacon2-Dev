library(ggplot2)
library(ggpubr)

infile = commandArgs(TRUE)[1]
outfile = commandArgs(TRUE)[2]

d = read.delim(infile, header = FALSE)

names(d) = c("bin", "id", "chr", "start", "end", "TF_count")

g = c(
  "0_0.001",
  "0.001_0.1",
  "0.1_0.5",
  "0.5_0.9",
  "0.9_0.999",
  "0.999_1"
)

d$bin = factor(d$bin, levels = g)

cmp = Map(c, g[-length(g)], g[-1])

p = ggplot(d, aes(bin, TF_count, fill = bin)) +
  geom_boxplot(outlier.size = 0.2) +
  stat_compare_means(
    comparisons = cmp,
    method = "wilcox.test",
    label = "p.format",
    step.increase = 0.08
  ) +
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    legend.position = "none",
    axis.text.x = element_text(angle = 30, hjust = 1),
    plot.title = element_text(hjust = 0.5)
  ) +
  labs(
    x = "G4 confidence interval",
    y = "Number of distinct overlapping TFs",
    title = "TFBS overlap per G4 region"
  )

ggsave(outfile, p, width = 7, height = 5.5, dpi = 300)