library(caret)
library(ggplot2)
library(scales)
library(writexl)


df <- read.table("HepG2Train_K562_PQSfinder_G4Hunter_Gmotif_GDNABERT_QFS_F1.0.bed", header=FALSE)
colnames(df) <- c("chr","start","end","G4Beacon2","label","PQSfinder","G4Hunter","Gmotif","GDNABERT","quadparser")

plot_cm <- function(cm, title){
  cm_table <- as.table(cm$table)
  cm_df <- as.data.frame(cm_table)

  # overall
  total <- sum(cm_df$Freq)                   
  cm_df$prop <- cm_df$Freq / total           
  cm_df$label_txt <- sprintf("%d\n(%s)",     
                             cm_df$Freq,    
                             percent(cm_df$prop, accuracy = 0.01))  

  # proportion
  p <- ggplot(cm_df, aes(Prediction, Reference, fill = prop)) + 
    geom_tile() +
    geom_text(aes(label = label_txt), color="white", size=6) + 
    scale_fill_gradient(low="lightblue", high="blue",           
                        limits = c(0, 1),                       
                        labels = percent_format(accuracy = 1),  
                        name = "Proportion") +                  
    ggtitle(title) +
    theme_minimal()

  return(p)
}

for (col in c("G4Beacon2","PQSfinder","G4Hunter","Gmotif","GDNABERT","quadparser")) {
  y_true <- factor(df$label, levels=c(0,1))
  y_pred <- factor(ifelse(df[[col]] > 0.5, 1, 0), levels=c(0,1))

  cm <- confusionMatrix(y_pred, y_true, positive="1")
  print(col)
  print(cm)

  # PNG
  p <- plot_cm(cm, paste("Confusion Matrix -", col))
  ggsave(filename=paste0("CM_", col, "_F1.0.png"), plot=p, width=4, height=3, dpi=300)
  
  # xlsx
  
  writexl::write_xlsx(list(
  overall = as.data.frame(t(cm$overall)),
  byClass = as.data.frame(t(cm$byClass)),
  table   = as.data.frame(cm$table)
), paste0("cm_", col, ".xlsx"))


}


