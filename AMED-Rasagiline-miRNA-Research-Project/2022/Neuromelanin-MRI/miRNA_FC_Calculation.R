library(tidyverse)
library(readr)
library(readxl)
library(matrixStats)
library(ggplot2)

# import data
X2022_rasagiline <- read_excel("2022_rasagiline.xlsx", skip = 4) %>% as.data.frame()
row.names(X2022_rasagiline) <- X2022_rasagiline$Gene 

# Select the 47 PD patients with exosome miRNA data for both before 
# and after rasagiline treatment
X2022_rasagiline <- X2022_rasagiline[,2:95]

# Remove PD10, who did not receive rasailine treatment
X2022_rasagiline <- X2022_rasagiline[,-19:-20]
miRNA <- X2022_rasagiline %>% as.matrix()
row.names(miRNA) <- row.names(X2022_rasagiline)

# Read Per Million Adjustment
miRNA <- apply(miRNA, 2, function(x){x/sum(x)})


# miRNA detected in less than half participants of the cohort is regarded as not efficiently detected
miRNA <- miRNA[rowMedians(miRNA) > 0,] 
min(miRNA[miRNA > 0])
miRNA <- miRNA * 10 ^ 8

# For remaining undetected miRNA,
# Their values shall be assigned as half of the minimum value of the detected target miRNA
miRNA[miRNA == 0] <- NA
nas <- which(is.na(miRNA), arr.ind = TRUE)
miRNA[nas] <- round((rowMins(miRNA, na.rm = TRUE) [nas[,1]]+1)/2) 
miRNA <- miRNA %>% as.data.frame()

# Select the exosome mirna data before rasagiline treatment
col_even <- seq_len(ncol(miRNA)) %% 2  
Visit1 <- miRNA[,col_even == 1]
Visit2 <- miRNA[,col_even == 0]
FC <- Visit2/Visit1


# write data
write_csv(Visit1, 'Visit1_miRNA.csv')
write_csv(Visit2, 'Visit2_miRNA.csv')
write_csv(FC, 'FC_miRNA.csv')
