## !/bin/bash

## ensure bowtie2 in path

## to map the trimmed Phi29 sequencing data to reference assemblies from NCBI

while read f1 f2
do
  bowtie2-build ../All_TenaciPlasPhi29_SequencingData_Mapping/TenaciCompleteAssemblies/${f2}.fasta ../All_TenaciPlasPhi29_SequencingData_Mapping/TenaciCompleteAssemblies/${f2}
  wait
  bowtie2 -x ../All_TenaciPlasPhi29_SequencingData_Mapping/TenaciCompleteAssemblies/${f2} -1 ../All_TenaciPlasPhi29_SequencingData_Trimmed/${f1}_L001_R1_001_fastpTrim.fastq.gz -2 ../All_TenaciPlasPhi29_SequencingData_Trimmed/${f1}_L001_R2_001_fastpTrim.fastq.gz --dovetail -S ../All_TenaciPlasPhi29_SequencingData_Mapping/${f1}_to_${f2}.sam
  wait
done < TenaciPlasPhi29Samples_andRefs

##fin
