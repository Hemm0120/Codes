cd /research/gmh/GENOME_DB/DownLoad/biomirror/ncbigenomes/Bacteria_DRAFT/ #Parent Directory of subdirectories containing fasta.tgz files 
var=".faa" #Substring to look for at end of string (file) 
for file in *; do
	cd /research/gmh/GENOME_DB/DownLoad/biomirror/ncbigenomes/Bacteria_DRAFT/$file/ #CD to Subdirectory
	for fileA in *; do
		if [ ${fileA: -7} == "faa.tgz" ] #If file ends with .faa.tgz
		then
			echo "$file"
			tar -ztf /research/gmh/GENOME_DB/DownLoad/biomirror/ncbigenomes/Bacteria_DRAFT/$file/$fileA| grep $var | wc -l
		fi	
	done
done 