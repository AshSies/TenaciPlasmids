setwd("BLAST_results/")
library(tidyverse)
library(ggprism)
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
#   [1] ggprism_1.0.5   tidyqpcr_1.0    lubridate_1.9.4 forcats_1.0.0   stringr_1.5.1  
# [6] dplyr_1.1.4     purrr_1.0.2     readr_2.1.5     tidyr_1.3.1     tibble_3.2.1   
# [11] ggplot2_3.5.1   tidyverse_2.0.0
# 
# loaded via a namespace (and not attached):
#   [1] utf8_1.2.4        generics_0.1.3    stringi_1.8.4     lattice_0.22-6   
# [5] hms_1.1.3         digest_0.6.37     magrittr_2.0.3    grid_4.3.1       
# [9] timechange_0.3.0  Matrix_1.5-4.1    mgcv_1.9-1        fansi_1.0.6      
# [13] viridisLite_0.4.2 scales_1.3.0      cli_3.6.3         rlang_1.1.4      
# [17] crayon_1.5.3      bit64_4.5.2       munsell_0.5.1     splines_4.3.1    
# [21] withr_3.0.2       tools_4.3.1       parallel_4.3.1    tzdb_0.4.0       
# [25] colorspace_2.1-1  assertthat_0.2.1  vctrs_0.6.5       R6_2.5.1         
# [29] lifecycle_1.0.4   bit_4.5.0.1       vroom_1.6.5       pkgconfig_2.0.3  
# [33] pillar_1.9.0      gtable_0.3.6      glue_1.8.0        tidyselect_1.2.1 
# [37] rstudioapi_0.17.1 farver_2.1.2      nlme_3.1-166      labeling_0.4.3   
# [41] compiler_4.3.1  

## File paths herein assume running from top-level directory

###### bacteria no Flavos ######
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae <- read_csv("./TenaciPlas_vs_RefSeq_BacteriaNOTFlavobacteriaceae.csv", col_names = FALSE)

TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple <- TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae %>% select(1, 3, 4)
Headers = c("put_plasmid", "aln_pid", "aln_len")
colnames(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple) <- Headers

TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "JAQKAW010000003.1", "pTd1")
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "JAQKAW010000005.1", "pTd2")
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "JAQKAW010000002.1", "pTd3")
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "CP116298.1", "pTff1")
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "CP116302.1", "pTff2")
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "CP116300.1", "pTff3")
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "CP116299.1", "pTff4")
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "CP116296.1", "pTfu1")
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "JAQKAV010000001.1", "pTm1")
TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid <- str_replace(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple$put_plasmid, "JAQKAV010000003.1", "pTm2")


BacteriaNoFlavos <- ggplot(TenaciPlas_vs_RefseqBacteria_noFlavobacteriaceae_simple,
                    mapping = aes(x = put_plasmid, y = aln_len, color = aln_pid,)) + 
                    geom_point(size = 2.5, position = position_jitterdodge(dodge.width = 1)) + 
                    theme_prism(base_size = 11) + 
                    theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust=1)) +
                    theme(axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
                    labs(y = "Alignment Length", x = "Putative Plasmid") +
                    scale_color_viridis_c(option = "turbo") +
                    scale_x_discrete(limits = c("pTm1", "pTm2", "pTd1", "pTd2", "pTd3", "pTff1", "pTff2", "pTff3", "pTff4", "pTfu1")) +
                    scale_y_continuous(
                      limits = c(0, 35000),
                      expand = c(0, 0),
                      breaks = seq(0, 35000, 5000),
                      guide = "prism_offset"
                    ) 

BacteriaNoFlavos

###### Flavos no Tenaci ######
TenaciPlas_vs_FlavosNoTenaci <- read_tsv("./TenaciPlas_vs_RefseqFlavosNoTenaci.tsv", col_names = FALSE)

TenaciPlas_vs_FlavosNoTenaci_simple <- TenaciPlas_vs_FlavosNoTenaci %>% select(1, 3, 4)
Headers = c("put_plasmid", "aln_pid", "aln_len")
colnames(TenaciPlas_vs_FlavosNoTenaci_simple) <- Headers

TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "JAQKAW010000003.1", "pTd1")
TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "JAQKAW010000005.1", "pTd2")
TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "JAQKAW010000002.1", "pTd3")
TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "CP116298.1", "pTff1")
TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "CP116302.1", "pTff2")
TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "CP116300.1", "pTff3")
TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "CP116299.1", "pTff4")
TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "CP116296.1", "pTfu1")
TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "JAQKAV010000001.1", "pTm1")
TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid <- str_replace(TenaciPlas_vs_FlavosNoTenaci_simple$put_plasmid, "JAQKAV010000003.1", "pTm2")


FlavosNoTenaci <- ggplot(TenaciPlas_vs_FlavosNoTenaci_simple,
                   mapping = aes(x = put_plasmid, y = aln_len, color = aln_pid,)) + 
  geom_point(size = 2.5, position = position_jitterdodge(dodge.width = 1)) + 
  theme_prism(base_size = 11) + 
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust=1)) +
  theme(axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
  labs(y = "Alignment Length", x = "Putative Plasmid") +
  scale_color_viridis_c(option = "turbo") +
  scale_x_discrete(limits = c("pTm1", "pTm2", "pTd1", "pTd2", "pTd3", "pTff1", "pTff2", "pTff3", "pTff4", "pTfu1")) + 
  scale_y_continuous(
    limits = c(0, 35000),
    expand = c(0, 0),
    breaks = seq(0, 35000, 5000),
    guide = "prism_offset"
  ) 

FlavosNoTenaci


### Tenaci > 400
TenaciPlas_vs_Tenaci400Plus <- read_tsv("./TenaciPlas_vs_RefseqTenacisMin400Kb.tsv", col_names = FALSE)

TenaciPlas_vs_Tenaci400Plus_simple <- TenaciPlas_vs_Tenaci400Plus %>% select(1, 3, 4)
Headers = c("put_plasmid", "aln_pid", "aln_len")
colnames(TenaciPlas_vs_Tenaci400Plus_simple) <- Headers

TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "JAQKAW010000003.1", "pTd1")
TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "JAQKAW010000005.1", "pTd2")
TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "JAQKAW010000002.1", "pTd3")
TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "CP116298.1", "pTff1")
TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "CP116302.1", "pTff2")
TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "CP116300.1", "pTff3")
TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "CP116299.1", "pTff4")
TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "CP116296.1", "pTfu1")
TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "JAQKAV010000001.1", "pTm1")
TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci400Plus_simple$put_plasmid, "JAQKAV010000003.1", "pTm2")


Tenaci400Plus <- ggplot(TenaciPlas_vs_Tenaci400Plus_simple,
                         mapping = aes(x = put_plasmid, y = aln_len, color = aln_pid,)) + 
  geom_point(size = 2.5, position = position_jitterdodge(dodge.width = 1)) + 
  theme_prism(base_size = 11) + 
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust=1)) +
  theme(axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
  labs(y = "Alignment Length", x = "Putative Plasmid") +
  scale_color_viridis_c(option = "turbo") +
  scale_x_discrete(limits = c("pTm1", "pTm2", "pTd1", "pTd2", "pTd3", "pTff1", "pTff2", "pTff3", "pTff4", "pTfu1")) + 
  scale_y_continuous(
    limits = c(0, 35000),
    expand = c(0, 0),
    breaks = seq(0, 35000, 5000),
    guide = "prism_offset"
  ) 

Tenaci400Plus


### Tenaci 100-400
TenaciPlas_vs_Tenaci1to400 <- read_tsv("./TenaciPlas_vs_RefseqTenacis100-400Kb.tsv", col_names = FALSE)

TenaciPlas_vs_Tenaci1to400_simple <- TenaciPlas_vs_Tenaci1to400 %>% select(1, 3, 4)
Headers = c("put_plasmid", "aln_pid", "aln_len")
colnames(TenaciPlas_vs_Tenaci1to400_simple) <- Headers

TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "JAQKAW010000003.1", "pTd1")
TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "JAQKAW010000005.1", "pTd2")
TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "JAQKAW010000002.1", "pTd3")
TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "CP116298.1", "pTff1")
TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "CP116302.1", "pTff2")
TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "CP116300.1", "pTff3")
TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "CP116299.1", "pTff4")
TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "CP116296.1", "pTfu1")
TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "JAQKAV010000001.1", "pTm1")
TenaciPlas_vs_Tenaci1to400_simple$put_plasmid <- str_replace(TenaciPlas_vs_Tenaci1to400_simple$put_plasmid, "JAQKAV010000003.1", "pTm2")


Tenaci1to400 <- ggplot(TenaciPlas_vs_Tenaci1to400_simple,
                        mapping = aes(x = put_plasmid, y = aln_len, color = aln_pid,)) + 
  geom_point(size = 2.5, position = position_jitterdodge(dodge.width = 1)) + 
  theme_prism(base_size = 11) + 
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust=1)) +
  theme(axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
  labs(y = "Alignment Length", x = "Putative Plasmid") +
  scale_color_viridis_c(option = "turbo") +
  scale_x_discrete(limits = c("pTm1", "pTm2", "pTd1", "pTd2", "pTd3", "pTff1", "pTff2", "pTff3", "pTff4", "pTfu1")) + 
  scale_y_continuous(
    limits = c(0, 35000),
    expand = c(0, 0),
    breaks = seq(0, 35000, 5000),
    guide = "prism_offset"
  ) 

Tenaci1to400

### Tenaci under 100
TenaciPlas_vs_TenaciMax100 <- read_tsv("./TenaciPlas_vs_RefseqTenacisMax100Kb.tsv", col_names = FALSE)

TenaciPlas_vs_TenaciMax100_simple <- TenaciPlas_vs_TenaciMax100 %>% select(1, 3, 4)
Headers = c("put_plasmid", "aln_pid", "aln_len")
colnames(TenaciPlas_vs_TenaciMax100_simple) <- Headers

TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "JAQKAW010000003.1", "pTd1")
TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "JAQKAW010000005.1", "pTd2")
TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "JAQKAW010000002.1", "pTd3")
TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "CP116298.1", "pTff1")
TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "CP116302.1", "pTff2")
TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "CP116300.1", "pTff3")
TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "CP116299.1", "pTff4")
TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "CP116296.1", "pTfu1")
TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "JAQKAV010000001.1", "pTm1")
TenaciPlas_vs_TenaciMax100_simple$put_plasmid <- str_replace(TenaciPlas_vs_TenaciMax100_simple$put_plasmid, "JAQKAV010000003.1", "pTm2")


TenaciMax100 <- ggplot(TenaciPlas_vs_TenaciMax100_simple,
                       mapping = aes(x = put_plasmid, y = aln_len, color = aln_pid,)) + 
  geom_point(size = 2.5, position = position_jitterdodge(dodge.width = 1)) + 
  theme_prism(base_size = 11) + 
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust=1)) +
  theme(axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
  labs(y = "Alignment Length", x = "Putative Plasmid") +
  scale_color_viridis_c(option = "turbo") +
  scale_x_discrete(limits = c("pTm1", "pTm2", "pTd1", "pTd2", "pTd3", "pTff1", "pTff2", "pTff3", "pTff4", "pTfu1")) + 
  scale_y_continuous(
    limits = c(0, 35000),
    expand = c(0, 0),
    breaks = seq(0, 35000, 5000),
    guide = "prism_offset"
  )  

TenaciMax100
