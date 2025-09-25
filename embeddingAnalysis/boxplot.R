library(ggplot2)
library(ggpubr)

bed_files <- c("UpstreamAll_1000shuf_embedding.csv",
               "DownstreamAll_1000shuf_embedding.csv",
               "ExonsAll_1kbScale_embedding.csv",
               "IntronsAll_1kbScale_embedding.csv",
               "NegativeFromGeneAndUpDown_Shuffle42_1000shuf_embedding.csv"
               )
group_labels <- c("upstream", "downstream", "exons", "introns", "intergenic")

combined_data <- do.call(rbind, lapply(seq_along(bed_files), function(i) {
  bed  <- read.csv(bed_files[i], header = FALSE, stringsAsFactors = FALSE)
  temp <- bed[[99]]
  val  <- suppressWarnings(as.numeric(temp))
  val  <- val[is.finite(val)]
  data.frame(group = group_labels[i], value = val, stringsAsFactors = FALSE)
}))


combined_data$group <- factor(combined_data$group,
                              levels = c("upstream", "downstream", "exons", "introns", "intergenic"))

comparisons <- list(
  c("upstream","downstream"),
  c("upstream","exons"),
  c("upstream","introns"),
  c("upstream","intergenic"),
)

p <- ggplot(combined_data, aes(x = group, y = value)) +
  geom_boxplot(outlier.size = 0.8, outlier.color = "black", fill = "lightblue") +
  labs(x = NULL, y = "Embedding Value") +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  stat_compare_means(comparisons = comparisons,
                     method = "wilcox.test",
                     label = "p.format",
                     step.increase = 0.1,
                     hide.ns = FALSE)

print(p)
ggsave("boxplot_99_1KB.png", plot = p, width = 8, height = 5, dpi = 300)
