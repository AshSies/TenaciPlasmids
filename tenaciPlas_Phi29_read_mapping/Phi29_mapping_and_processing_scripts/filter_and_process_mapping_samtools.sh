#!/bin/bash
## Using samtools v1.19.2

## Ensure samtools in $PATH

while read x1
do
  samtools sort ../All_TenaciPlasPhi29_SequencingData_Mapping/${x1}.sam -o ../All_TenaciPlasPhi29_SequencingData_Mapping/${x1}_sorted.bam
  wait
  samtools view -b -q 10 ../All_TenaciPlasPhi29_SequencingData_Mapping/${x1}_sorted.bam > ../All_TenaciPlasPhi29_SequencingData_Mapping/${x1}_sorted_filterMAPQ10.bam
  wait
  samtools index ../All_TenaciPlasPhi29_SequencingData_Mapping/${x1}_sorted_filterMAPQ10.bam
  wait
  samtools idxstats ../All_TenaciPlasPhi29_SequencingData_Mapping/${x1}_sorted_filterMAPQ10.bam > ../All_TenaciPlasPhi29_SequencingData_Mapping/${x1}_sorted_filterMAPQ10_samtoolsIDX
  wait
done < inputSamFiles

mkdir ../../tenaciPlas_Phi29_mapping_data

mv ../All_TenaciPlasPhi29_SequencingData_Mapping/*IDX ../../tenaciPlas_Phi29_mapping_data
#fin
