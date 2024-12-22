#### To process read mapping after Phi29 amplification of plasmid-containing Tenacibaculum isolates #### 
#### Sequencing performed on Illumina Miniseq
#### Raw reads trimmed and filtered using fastp v.0.23.4
#### Reads mapped to reference Tenaci seqs (pulled from NCBI) using bowtie2 v.2.5.3
#### Mapping files processed and statistics extracted using samtools v1.19.2

library(tidyverse)
sessionInfo()
# R version 4.3.1 (2023-06-16)
# Platform: x86_64-apple-darwin20 (64-bit)
# Running under: macOS Sonoma 14.6.1
# 
# Matrix products: default
# BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib 
# LAPACK: /Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/lib/libRlapack.dylib;  LAPACK version 3.11.0
# 
# locale:
#   [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
# 
# time zone: America/Vancouver
# tzcode source: internal
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] lubridate_1.9.4 forcats_1.0.0   stringr_1.5.1   dplyr_1.1.4     purrr_1.0.2    
# [6] readr_2.1.5     tidyr_1.3.1     tibble_3.2.1    ggplot2_3.5.1   tidyverse_2.0.0
# 
# loaded via a namespace (and not attached):
#   [1] vctrs_0.6.5       cli_3.6.3         rlang_1.1.4       stringi_1.8.4    
# [5] generics_0.1.3    glue_1.8.0        colorspace_2.1-1  hms_1.1.3        
# [9] scales_1.3.0      fansi_1.0.6       grid_4.3.1        munsell_0.5.1    
# [13] tzdb_0.4.0        lifecycle_1.0.4   compiler_4.3.1    timechange_0.3.0 
# [17] pkgconfig_2.0.3   rstudioapi_0.17.1 R6_2.5.1          tidyselect_1.2.1 
# [21] utf8_1.2.4        pillar_1.9.0      magrittr_2.0.3    tools_4.3.1      
# [25] withr_3.0.2       gtable_0.3.6 

## File paths assume running from top-level directory
setwd("./tenaciPlas_samtools_filtered_mapping_data/")
# List all CSV files in the directory
Depth_files <- list.files(pattern = "*Depth")
Summary_files <- list.files(pattern = "*IDX")

data_list <- list()
data_list2 <- list()

#### Depth summary statistics #### 
for (file in Depth_files) {
  data <- read_tsv(file)
    data_list[[file]] <- data
}

for(i in 1:length(data_list)) {
  colnames(data_list[[i]]) <- c("replicon", "pos", "dpth")
}

depth_summary_stat_list = list()

for (i in 1:length(data_list)) {
  dpthsumm <-
    data_list[[i]] %>% group_by(replicon) %>% summarise(
      mean = mean(dpth),
      stdev = sd(dpth),
      med = median(dpth),
      q1 = quantile(dpth, probs = 0.25),
      q3 = quantile(dpth, probs = 0.75),
      n = n()
    )
  dpthsumm$file <- names(data_list)[i]
 depth_summary_stat_list[[i]] <- dpthsumm 
}

depth_summary_stats = do.call(rbind, depth_summary_stat_list)

#### RPKM summary statistics #### 
for (file in Summary_files) {
  data <- read_tsv(file, col_names = FALSE)
  data_list2[[file]] <- data
}

for(i in 1:length(data_list2)) {
  colnames(data_list2[[i]]) <- c("replicon","size", "reads", "other")
  data_list2[[i]] <- data_list2[[i]] %>% select(-4)
  data_list2[[i]] <- head(data_list2[[i]], -1)
}


for (i in 1:length(data_list2)) {
  total_mapped_reads = sum(data_list2[[i]]$reads)
  data_list2[[i]] <- data_list2[[i]] %>% mutate(RPKM = ((reads/(size/1000))/(total_mapped_reads/1000000)))
  data_list2[[i]]$isolate_total_mapped_reads <- total_mapped_reads
  total_mapped_reads = 0
  data_list2[[i]]$file <- names(data_list2)[i]
}

RPKM_summary_stats = do.call(rbind, data_list2)
row.names(RPKM_summary_stats) <- NULL

#### rename replicons across summaries #### 

RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAW010000003.1", "pTd1")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAW010000005.1", "pTd2")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAW010000002.1", "pTd3")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "CP116298.1", "pTff1")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "NZ_CP116302.1", "pTff2")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "CP116300.1", "pTff3")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "CP116299.1", "pTff4")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "NZ_CP116296.1", "pTfu1")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAV010000001.1", "pTm1")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAV010000003.1", "pTm2")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "NC_007779.1", "E. coli W3110 Chromosome")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "HE654725.1:10539-86908,1-8294", "pCol1b9 -cib -imm")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "pOT1_Ahmadi_seq", "pOT1")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "pWSK29CI_Ahmadi_seq", "pWSK29")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "NZ_CP116297.1", "T. fin. gv. ulcerans LI C6 FM3-F Chromosome")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAW010000001.1", "T. dicentrarchi 20-4116-9 Chromosome Fragment 1")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAW010000004.1", "T. dicentrarchi 20-4116-9 Chromosome Fragment 2")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAV010000002.1", "T. maritimum 2.1C Chromosome Fragment 1")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAV010000004.1", "T. maritimum 2.1C Chromosome Fragment 2")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "JAQKAV010000005.1", "T. maritimum 2.1C Chromosome Fragment 3")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "CP116301.1", "T. fin. gv. finnmarkense 17-2576-1 Chromosome")
RPKM_summary_stats$replicon <- str_replace(RPKM_summary_stats$replicon, "NZ_CP116303.1", "T. fin. gv. finnmarkense 20-4106-2 Chromosome")

depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAW010000003.1", "pTd1")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAW010000005.1", "pTd2")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAW010000002.1", "pTd3")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "CP116298.1", "pTff1")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "NZ_CP116302.1", "pTff2")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "CP116300.1", "pTff3")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "CP116299.1", "pTff4")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "NZ_CP116296.1", "pTfu1")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAV010000001.1", "pTm1")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAV010000003.1", "pTm2")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "NC_007779.1", "E. coli W3110 Chromosome")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "HE654725.1:10539-86908,1-8294", "pCol1b9 -cib -imm")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "pOT1_Ahmadi_seq", "pOT1")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "pWSK29CI_Ahmadi_seq", "pWSK29")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "NZ_CP116297.1", "T. fin. gv. ulcerans LI C6 FM3-F Chromosome")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAW010000001.1", "T. dicentrarchi 20-4116-9 Chromosome Fragment 1")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAW010000004.1", "T. dicentrarchi 20-4116-9 Chromosome Fragment 2")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAV010000002.1", "T. maritimum 2.1C Chromosome Fragment 1")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAV010000004.1", "T. maritimum 2.1C Chromosome Fragment 2")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "JAQKAV010000005.1", "T. maritimum 2.1C Chromosome Fragment 3")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "CP116301.1", "T. fin. gv. finnmarkense 17-2576-1 Chromosome")
depth_summary_stats$replicon <- str_replace(depth_summary_stats$replicon, "NZ_CP116303.1", "T. fin. gv. finnmarkense 20-4106-2 Chromosome")

#### export #### 

write_csv(RPKM_summary_stats, "../tables/RPKM_summary_statistics_Phi29Experiment_filteredMapData_2024-03.csv")
write_csv(depth_summary_stats, "../tables/Depth_summary_statistics_Phi29Experiment_filteredMapData_2024-03.csv")