cd /Winnebago/thomas/Documents/draftA/

for file in *; do
	cat *faa | xargs -o -n 3| uniq| awk '{print $1" "$2"\n"3 }' > combined.fasta
done 