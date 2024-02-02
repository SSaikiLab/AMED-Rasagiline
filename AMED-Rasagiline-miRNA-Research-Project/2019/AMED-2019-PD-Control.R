library(readxl)
library(dplyr)
library(matrixStats)
library(ggplot2)
library(pcaExplorer)

# Load data
mirna_2019 <- read_excel("AMED-2019-PD-Control.xlsx") 
mirna_2019 <- mirna_2019[1:2792,]
Rnames <- mirna_2019$Geneid

# Remove PD patient 13 and patient 15 for failure in meeting cohort admission standard
mirna_2019 <- mirna_2019[,-1:-6] %>%
  select(J1:J12, J14, J16:J42) %>% 
  as.data.frame()
row.names(mirna_2019) <- Rnames

# Trim data for DESeq2 analysis
mirna <- mirna_2019[,] %>% as.matrix()
mirna <- apply(mirna, 2, as.numeric)
mirna <- apply(mirna, 2, as.integer)
row.names(mirna) <- row.names(mirna_2019)

# Remove miRNA detected in less than half participants of the cohort
mirna <- mirna[rowMedians(mirna) > 0,] 

# For remaining undetected miRNA,
# Their values shall be assigned as half of the minimum value of the detected target miRNA
mirna[mirna == 0] <- NA
nas <- which(is.na(mirna), arr.ind = TRUE)
mirna[nas] <- round((rowMins(mirna, na.rm = TRUE, useNames = TRUE) [nas[,1]]+1)/2)
mirna <- mirna %>% as.data.frame()

# DESeq2 
library(DESeq2)
colData <- cbind(c(colnames(mirna)), c(replicate(19,"PD"),replicate(21,"HC")))
colnames(colData) <- c("Patient","Disease")
dds <- DESeqDataSetFromMatrix(countData = mirna, colData = colData, design = ~Disease)
dds$Disease <- relevel(dds$Disease, ref = "HC")
dds <- DESeq(dds)
res <- results(dds)


# Visualization
vsdata <- varianceStabilizingTransformation(dds, blind = FALSE)
plotPCA(vsdata, intgroup = "Disease")
pcaExplorer(dds = dds, dst = vsdata)
results <- res %>%  as.data.frame()
results$miRNA <- row.names(results)
results$miRNA <- gsub(".*_","",results$miRNA)
IncreasedmiRNA <- results %>% filter(padj<= 0.05, log2FoldChange < 0)
DecreasedmiRNA <- results %>% filter(padj<= 0.05, log2FoldChange > 0)

# Save data
write.csv(results, "Results-2019.csv")
write.csv(IncreasedmiRNA, "Increased-miRNA.csv")
write.csv(DecreasedmiRNA, "Decreased-miRNA.csv")
