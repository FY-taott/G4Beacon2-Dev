library(ggplot2)

files <- c("K562_m10_withPQS_all_gc_content.txt", 
           "K562_m10_withoutPQS_all_with20score_gc_content.txt", 
           "K562_m10_withoutPQS_all_without20score_gc_content.txt",
           "K562_m10_peaks_all_negativeShuffle42_gc_content.txt")
           
labels <- c("withPQS","withoutPQS_over20","withoutPQS_below20","shuf")

read_gc_col2 <- function(f, lab){
  x  <- read.table(f, header = FALSE, sep = "", comment.char = "#",
                   quote = "", stringsAsFactors = FALSE)
  gc <- suppressWarnings(as.numeric(x[[2]]))
  gc <- gc[is.finite(gc)]
  data.frame(File = lab, GC = gc)
}
df <- do.call(rbind, Map(read_gc_col2, files, labels))

df$File <- factor(df$File, levels = c("withPQS","withoutPQS_over20","withoutPQS_below20","shuf"))


p <- ggplot(df, aes(x = GC, color = File)) +
  geom_density(linewidth = 1) + 
  #coord_cartesian(xlim = c(0, 1)) +        
  labs(x = "GC content", y = "Density",
       title = "GC content density (smoothed)") +
  theme_bw() + theme(panel.grid = element_blank())

print(p)
ggsave("gc_content_density.png", p, width = 8, height = 5, dpi = 300)
ggsave("gc_content_density.pdf", p, width = 8, height = 5)
