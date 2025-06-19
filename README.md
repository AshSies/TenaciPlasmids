# TenaciPlasmids

#### Contains data and scripts pertinent to [Discovery and assembly of plasmids in the fish pathogen _Tenacibaculum_](https://doi.org/10.1016/j.plasmid.2025.102753)

![Figure_1_Sies_et_al_Plasmid_print-ppi600_3x5](https://github.com/user-attachments/assets/e4c7eddf-a36a-4b9d-807c-0f08d38f9d89)

#### Contents

Nucleotide sequences of the ten newly discovered plasmids are contained within /tenaciPlas_fastas/. The putative _Tenacibaculum_ plasmid contained within IMG/PR and  publicly available _Tenacibaculum_ assemblies that were aligned to the newly discovered plasmid sequences are contained within /External_seqs_for_alignments/. 
 
Sequencing datasets generated and analyzed during the current study are available in the Sequencing Read Archive: https://www.ncbi.nlm.nih.gov/sra/PRJNA1276104  

fastq's available on SRA can be placed in /tenaciPlas_Phi29_read_mapping/All_TenaciPlasPhi29_SequencingData_Trimmed/, then shell scripts can be run from /tenaciPlas_Phi29_read_mapping/Phi29_mapping_and_scripts/ to recreate mapping summary files contained within /tenaciPlas_Phi29_mapping_data/.

Code to visualize qPCR experimental data, Phi29 read mapping values across _Tenacibaculum_ plasmids (plus their respective host chromosomes, where applicable), and summaries of BLAST alignments between existing data in Refseq and the newly discovered plasmid sequences, is available within /r_scripts/.   

