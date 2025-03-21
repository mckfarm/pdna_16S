#!/bin/bash

#SBATCH --job-name="dada2"
#SBATCH -A b1042
#SBATCH --mail-type=ALL
#SBATCH --mail-user=zhenjia2020@u.northwestern.edu
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem=40G
#SBATCH -t 24:00:00
#SBATCH --output=/projects/b1052/Zhen/dada2_out
#SBATCH --error=/projects/b1052/Zhen/dada2_err
#SBATCH -p genomicsguest

module purge all

module load qiime2/2023.2


# run dada2 to denoise as ASVs
# here I use 25th percentile higher than Q25 to pick truncate locations
qiime dada2 denoise-paired --verbose \
--i-demultiplexed-seqs /projects/b1052/Zhen/trimmed_PdNA1_BC_combined_classified_1st_2nd_batch_samples-demux-paired-end.qza \
--p-trunc-len-f 223 --p-trunc-len-r 200 \
--o-representative-sequences /projects/b1052/Zhen/rep_seqs_dada2.qza \
--o-table /projects/b1052/Zhen/table_dada2.qza \
--o-denoising-stats /projects/b1052/Zhen/stats_dada2.qza


qiime metadata tabulate \
--m-input-file /projects/b1052/Zhen/stats_dada2.qza \
--o-visualization /projects/b1052/Zhen/stats_dada2.qzv


qiime feature-table summarize \
--i-table /projects/b1052/Zhen/table_dada2.qza \
--o-visualization /projects/b1052/Zhen/table_dada2.qzv


qiime feature-table tabulate-seqs \
--i-data /projects/b1052/Zhen/rep_seqs_dada2.qza \
--o-visualization /projects/b1052/Zhen/rep_seqs_dada2.qzv