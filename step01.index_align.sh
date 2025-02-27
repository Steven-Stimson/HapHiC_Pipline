set -e
# Index and Alignment
export PATH=/opt/software/miniconda3/envs/samtools/bin:$PATH
export PATH=/opt/software/miniconda3/envs/chromap/bin:$PATH

EntityID=$1
Threads=$2
HiC_R1=$3
HiC_R2=$4

samtools faidx ${EntityID}.fa
chromap -i -r ${EntityID}.fa -o ${EntityID}.index 2>&1 | perl -ne '(/number of bases: (\d+)\.$/) && (print "assembly $1\n")'> ${EntityID}.chrom.sizes

echo "Index Done."

chromap --preset hic -r ${EntityID}.fa -x ${EntityID}.index \
-t ${Threads} --pairs -o ${EntityID}.hicaln.pairs \
-1 ${HiC_R1} \
-2 ${HiC_R2} \

echo "Alignment Done."
