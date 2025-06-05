#!/bin/bash

mkdir tenaciPlas_fastas
cat TenaciPlasContigAccs.txt | {
while read line
do
wget "https://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?db=nuccore&report=fasta&id=${line}" -O ./tenaciPlas_fastas/"$line".fasta
sleep 1
done
}
