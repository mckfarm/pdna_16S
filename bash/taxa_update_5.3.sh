#!/bin/bash

#SBATCH --job-name="taxa"
#SBATCH -A p31629
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem=20G
#SBATCH -t 04:00:00
#SBATCH --output=/projects/p31629/zhen_check/from_zhen/taxa.err
#SBATCH --error=/projects/p31629/zhen_check/from_zhen/taxa.out
#SBATCH -p short

module purge all

module load qiime2/2023.2

# classify sequences using Midas database specifically designed for activated sludge and anaerobic digester
#the classifier is compatible with qiime2/2023.2
qiime feature-classifier classify-sklearn \
--i-classifier /projects/b1052/mckenna/resources/midas_5.3/midas_5.3_classifier.qza \
--i-reads /projects/p31629/zhen_check/from_zhen/rep_seqs_all.qza \
--o-classification /projects/p31629/zhen_check/from_zhen/taxonomy_5.3.qza