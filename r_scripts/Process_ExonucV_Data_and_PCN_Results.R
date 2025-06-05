library(tidyverse)
sessionInfo()
# R version 4.3.1 (2023-06-16)
# Platform: x86_64-apple-darwin20 (64-bit)
# Running under: macOS Sonoma 14.6.1

# Matrix products: default
# BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib 
# LAPACK: /Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/lib/libRlapack.dylib;  LAPACK version 3.11.0

# locale:
#  [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

# time zone: America/Vancouver
# tzcode source: internal
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] ggprism_1.0.5   lubridate_1.9.4 forcats_1.0.0   stringr_1.5.1   dplyr_1.1.4     purrr_1.0.2    
# [7] readr_2.1.5     tidyr_1.3.1     tibble_3.2.1    ggplot2_3.5.1   tidyverse_2.0.0
# 
# loaded via a namespace (and not attached):
#   [1] bit_4.5.0.1       gtable_0.3.6      crayon_1.5.3      compiler_4.3.1    tidyselect_1.2.1  parallel_4.3.1   
# [7] scales_1.3.0      R6_2.5.1          labeling_0.4.3    generics_0.1.3    munsell_0.5.1     pillar_1.9.0     
# [13] tzdb_0.4.0        rlang_1.1.4       utf8_1.2.4        stringi_1.8.4     bit64_4.5.2       viridisLite_0.4.2
# [19] timechange_0.3.0  cli_3.6.3         withr_3.0.2       magrittr_2.0.3    digest_0.6.37     grid_4.3.1       
# [25] vroom_1.6.5       rstudioapi_0.17.1 hms_1.1.3         lifecycle_1.0.4   vctrs_0.6.5       glue_1.8.0       
# [31] farver_2.1.2      fansi_1.0.6       colorspace_2.1-1  tools_4.3.1       pkgconfig_2.0.3  
#

#### ExoNucV ####
## File paths assume running from top-level directory
Plate1_Cq_results <- read.csv("./tenaciPlas_qPCRExpdata/TenaciPlasExoNuc_CqResults1.csv")

## Rough plot all data; check out points for each condition/target/etc.
ggplot(data = Plate1_Cq_results) +
  geom_point(aes(x = target_id,
                 y = cq,
                 colour = dilution,
                 shape = prep_type),
             position = position_jitter(width = 0.2, height = 0)
  ) +
  labs(
    y = "Cycle count to threshold")

## Plot Cq's
ggplot(data = filter(Plate1_Cq_results, prep_type %in% c("no_exo", "exo"))) +
  geom_point(aes(x = target_id, y = cq, shape = prep_type, colour = prep_type),
             position = position_jitter(width = 0.2, height = 0)
  ) +
  labs(
    y = "Quantification cycle (Cq)",
    title = "All reps, unnormalized"
  ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

Plate2_Cq_results <- read.csv("./tenaciPlas_qPCRExpdata/TenaciPlasExoNuc_CqResults2.csv")

ggplot(data = Plate2_Cq_results) +
  geom_point(aes(x = target_id,
                 y = cq,
                 shape = prep_type,
                 colour = dilution),
             position = position_jitter(width = 0.2, height = 0)
  ) +
  labs(
    y = "Cycle count to threshold")

ggplot(data = filter(Plate2_Cq_results, prep_type %in% c("non_exo", "exo"))) +
  geom_point(aes(x = target_id, y = cq, shape = prep_type, colour = prep_type),
             position = position_jitter(width = 0.2, height = 0)
  ) +
  labs(
    y = "Quantification cycle (Cq)",
    title = "All reps, unnormalized"
  ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

Plate3_Cq_results <- read.csv("./tenaciPlas_qPCRExpdata/TenaciPlasExoNuc_CqResults3.csv")

ggplot(data = Plate3_Cq_results) +
  geom_point(aes(x = target_id,
                 y = cq,
                 shape = prep_type,
                 colour = dilution),
             position = position_jitter(width = 0.2, height = 0)
  ) +
  labs(
    y = "Cycle count to threshold")

ggplot(data = filter(Plate3_Cq_results, prep_type %in% c("non_exo", "exo"))) +
  geom_point(aes(x = target_id, y = cq, shape = prep_type, colour = prep_type),
             position = position_jitter(width = 0.2, height = 0)
  ) +
  labs(
    y = "Quantification cycle (Cq)",
    title = "All reps, unnormalized"
  ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

Plate4_Cq_results <- read.csv("./tenaciPlas_qPCRExpdata/TenaciPlasExoNuc_CqResults4.csv")

ggplot(data = Plate4_Cq_results) +
  geom_point(aes(x = target_id,
                 y = cq,
                 shape = prep_type,
                 colour = dilution),
             position = position_jitter(width = 0.2, height = 0)
  ) +
  labs(
    y = "Cycle count to threshold")

ggplot(data = filter(Plate4_Cq_results, prep_type %in% c("non_exo", "exo"))) +
  geom_point(aes(x = target_id, y = cq, shape = prep_type, colour = prep_type),
             position = position_jitter(width = 0.2, height = 0)
  ) +
  labs(
    y = "Quantification cycle (Cq)",
    title = "All reps, unnormalized"
  ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

All_Results_Compiled = mget(ls(pattern = "results$"))
All_Cq_Results_Compiled <- bind_rows(All_Results_Compiled)
unique(All_Cq_Results_Compiled$prep_type)
All_Cq_Results_Compiled_forPlotting <- All_Cq_Results_Compiled %>% filter(prep_type %in% c("exo", "non_exo"))

ggplot(data = All_Cq_Results_Compiled_forPlotting) +
  geom_point(aes(x = target_id, y = cq, colour = prep_type),
             position = position_jitter(width = 0.2, height = 0)
  ) +
  labs(
    y = "Quantification cycle (Cq)",
    title = "All reps"
  ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

cq_forPlotting_summarized_mean_sd <- All_Cq_Results_Compiled_forPlotting %>% group_by(target_id, prep_type) %>%
  summarise_at(vars(cq), list(mean_cq = mean, sd_cq = sd))

cq_forPlotting_summarized_mean_sd$org <- case_when(
  cq_forPlotting_summarized_mean_sd$target_id %in% c("2X", "pTd1", "pTd2", "pTd3") ~ "T. dic. str. 20-4116-9",
  cq_forPlotting_summarized_mean_sd$target_id %in% c("3X", "pTff2") ~ "T. finn. finn. str. 20-4106-2",
  cq_forPlotting_summarized_mean_sd$target_id %in% c("4X", "pTff1", "pTff3", "pTff4") ~ "T. finn. finn. str. 17-2576-1",
  cq_forPlotting_summarized_mean_sd$target_id %in% c("9X", "pTm1", "pTm2") ~ "T. mar. str. 2.1C",
  cq_forPlotting_summarized_mean_sd$target_id %in% c("EX", "pWSK29") ~ "E. coli str. W3110")

cq_forPlotting_summarized_mean_sd$target_id <- cq_forPlotting_summarized_mean_sd$target_id %>% str_replace_all("2X", "Xsome")
cq_forPlotting_summarized_mean_sd$target_id <- cq_forPlotting_summarized_mean_sd$target_id %>% str_replace_all("3X", "Xsome")
cq_forPlotting_summarized_mean_sd$target_id <- cq_forPlotting_summarized_mean_sd$target_id %>% str_replace_all("4X", "Xsome")
cq_forPlotting_summarized_mean_sd$target_id <- cq_forPlotting_summarized_mean_sd$target_id %>% str_replace_all("9X", "Xsome")
cq_forPlotting_summarized_mean_sd$target_id <- cq_forPlotting_summarized_mean_sd$target_id %>% str_replace_all("EX", "Xsome")

ExoNucCqPlot <- ggplot(data = cq_forPlotting_summarized_mean_sd) +
  geom_point(aes(x = target_id, y = mean_cq, shape = prep_type, colour = prep_type), size = 3
  ) +
  geom_errorbar(aes(target_id, ymin = mean_cq-sd_cq, ymax = mean_cq+sd_cq), width=0.2
  ) +
  labs(
    y = "Quantification cycle (Cq)",
    x = "",
    title = ""
  ) +
  facet_wrap(~org, scales = "free_x") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  theme(legend.position = "none") +
  theme_light()

cq_mean_sd_normalizedVSnon_exo <- cq_forPlotting_summarized_mean_sd %>% pivot_wider(names_from = prep_type, values_from = c(mean_cq, sd_cq))
cq_mean_sd_normalizedVSnon_exo <- cq_mean_sd_normalizedVSnon_exo %>% mutate(exodiff = mean_cq_non_exo - mean_cq_exo, sdtotal = sqrt(sd_cq_exo^2 + sd_cq_non_exo^2))

cq_mean_sd_normalizedVSnon_exo$target_id <- cq_mean_sd_normalizedVSnon_exo$target_id %>% str_replace_all("2X", "Xsome")
cq_mean_sd_normalizedVSnon_exo$target_id <- cq_mean_sd_normalizedVSnon_exo$target_id %>% str_replace_all("3X", "Xsome")
cq_mean_sd_normalizedVSnon_exo$target_id <- cq_mean_sd_normalizedVSnon_exo$target_id %>% str_replace_all("4X", "Xsome")
cq_mean_sd_normalizedVSnon_exo$target_id <- cq_mean_sd_normalizedVSnon_exo$target_id %>% str_replace_all("9X", "Xsome")
cq_mean_sd_normalizedVSnon_exo$target_id <- cq_mean_sd_normalizedVSnon_exo$target_id %>% str_replace_all("EX", "Xsome")

NormExoNucCqPlot <- ggplot(data = cq_mean_sd_normalizedVSnon_exo, aes(x = target_id, y = exodiff)) +
  geom_bar(stat = "identity", color = "darkgreen", fill = "lightgreen") +
  labs(y = "Cq difference from non-exonuclease-treated samples") +
  facet_wrap(~org, scales = "free_x") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  theme_light()

NormExoNucCqPlot

#### Colony-qPCR PCN ####

qpcr_results <- read.csv("./tenaciPlas_qPCRExpdata/TenaciPlas_qPCR_PCN_Results.csv")
qpcr_results_wPCNs <- qpcr_results %>% mutate(PCN = ((((1+xsome_efficiency)^xsome_techrep_mean)/((1+efficiency)^techrep_mean))*(xsome_amplicon_size/amplicon_size)))

PCNPlot <- ggplot(data = qpcr_results_wPCNs, aes(x = target_id, y = PCN)) +
  geom_point(color = "darkorange", fill = "darkorange") +
  labs(y = "PCN") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  theme_light()

PCNPlot

