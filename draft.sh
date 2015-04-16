cd /research/gmh/GENOME_DB/DownLoad/biomirror/ncbigenomes/Bacteria_DRAFT/ #Parent Directory of subdirectories containing fasta.tgz files 
var=".faa.tgz" #Substring to look for at end of string (file) 
for file in *; do
	cd /research/gmh/GENOME_DB/DownLoad/biomirror/ncbigenomes/Bacteria_DRAFT/$file/ #CD to Subdirectory
	for fileA in *; do		
		if [ ${fileA: -15} == ".contig.faa.tgz" ] #If file ends with .faa.tgz
		then
			mkdir /Winnebago/thomas/Documents/draft/$file #Make a new directory with the same name as the sub directory 
			cd /Winnebago/thomas/Documents/draft/$file					
			tar -zxvf /research/gmh/GENOME_DB/DownLoad/biomirror/ncbigenomes/Bacteria_DRAFT/$file/$fileA # Extract .faa files
			for fileB in *; do #for extracted files..
				if [ ${fileB: -4} == ".faa" ] #Read each file, when .faa file is found do;
				then 
					newfile="/Winnebago/thomas/Documents/draft/$file/$fileB" #newfile = one of the faa files
					hmmsearch -A /Winnebago/thomas/Documents/draft/$file/${fileB%.faa}.sto /Winnebago/thomas/Documents/AOX.hmm $newfile ##Hmmsearch newfiles vs. AOX HMM
				fi
				
				if [[ -s /Winnebago/thomas/Documents/draft/$file/${fileB%.faa}.sto ]]; then
					echo "Significant Hit Found"
					
				else #remove blank files and nonsignificant .faa files ##Significant .faa files to be compiled later...
					rm /Winnebago/thomas/Documents/draft/$file/${fileB%.faa}.sto
					rm $newfile
				fi
			done
			
			if [ "$(ls -A /Winnebago/thomas/Documents/draft/$file)" ];then #If directory is not empty
				echo "$file"		
				gzcat /research/gmh/GENOME_DB/DownLoad/biomirror/ncbigenomes/Bacteria_DRAFT/$file/${fileA%.contig.faa.tgz}.gbk.gz >${fileA%.contig.faa.tgz}.gbk 					
			else 
				rm -rf /Winnebago/thomas/Documents/draft/$file #else remove empty subdirectories 
			fi 
		fi	
	done
done 