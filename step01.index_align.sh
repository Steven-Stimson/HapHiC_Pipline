# Index and Alignment 
export PATH=/opt/software/miniconda3/envs/samtools/bin:$PATH
export PATH=/opt/software/miniconda3/envs/chromap/bin:$PATH

EntityID=$1
Threads=$2
Contigs=$3
HiC_R1=$4
HiC_R2=$5

cp $Contigs ${EntityID}.fa
samtools faidx ${EntityID}.fa > step01.log 2>&1
chromap -i -r ${EntityID}.fa -o ${EntityID}.index 2>&1 | perl -ne '(/number of bases: (\d+)\.$/) && (print "assembly $1\n")'> ${EntityID}.chrom.sizes

echo "Index Done."

chromap --preset hic -r ${EntityID}.fa -x ${EntityID}.index \
-t ${Threads} --pairs -o hicaln.pairs \
-1 ${HiC_R1} \
-2 ${HiC_R2} \
> step01.log 2>&1

echo "Alignment Done."
