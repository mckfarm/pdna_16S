# parse seq data into RDS

library(qiime2R)
library(phyloseq)
library(tidyverse)


metadata_bc <- read_delim("./from_zhen/bc_map_metadata.txt") %>%
  mutate(`day-of-operation` = as.numeric(`day-of-operation`))
metadata_ss <- read_delim("./from_zhen/ss_map_metadata.txt") %>%
  mutate(`day-of-operation` = as.numeric(`day-of-operation`))

metadata_all <- bind_rows(metadata_bc, metadata_ss) %>%
  rename(day = `day-of-operation`) %>%
  filter(day <= 276)

rm(metadata_bc, metadata_ss)

ps_all <- qza_to_phyloseq(features = "./from_zhen/table_all.qza",
                          taxonomy = "./from_zhen/taxonomy_5.3.qza")

ps_rel <- transform_sample_counts(ps_all, function(x) x*100/sum(x))

taxonomy <- as.data.frame(as.matrix(ps_rel@tax_table)) %>% 
  rownames_to_column(var = "seq") # change the ASV ID to a column, not a row name

table_rel <- as.data.frame(as.matrix(ps_rel@otu_table)) %>% 
  rownames_to_column(var = "seq") %>%
  distinct(across(everything()))

table_rel_long <- table_rel %>% 
  pivot_longer(cols = !seq, names_to = "sample", values_to = "rel_ab") %>% # make a "long" dataframe
  left_join(taxonomy, join_by(seq)) %>%
  right_join(metadata_all, by = c("sample" = "sample-id")) 

saveRDS(table_rel_long, "./intermediate/table_rel_long.RDS")



rm(taxonomy, table_rel, ps_all)
