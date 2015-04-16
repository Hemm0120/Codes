rm -rf /Vagabundo/thomas/Documents/Aox_Files/DB
mkdir -p /Vagabundo/thomas/Documents/Aox_Files/DB
cd /research/gmh/GENOME_DB/faa-Genome/ #Parent Directory of subdirectories containing fasta.tgz files

var=".faa.bz2" #Substring to look for at end of string (file) 
echo "Stage One"
for file in *; do
	bunzip2 -c /research/gmh/GENOME_DB/faa-Genome/$file > /Vagabundo/thomas/Documents/Aox_Files/DB/${file%.bz2}
    echo "Processing...:"
done
echo "Stage Two"
cd  /Vagabundo/thomas/Documents/Aox_Files/DB/
for fileB in *; do #for extracted files..
	newfile="/Vagabundo/thomas/Documents/Aox_Files/DB/$fileB" #newfile = one of the faa files
	/Vagabundo/thomas/bin/hmmsearch -A /Vagabundo/thomas/Documents/Aox_Files/DB/${fileB%.faa}.sto -E 1e-3 /Vagabundo/thomas/Documents/Aox_Files/AOX.hmm $newfile ##Hmmsearch newfiles vs. AOX HMM
	
	if [[ -s /Vagabundo/thomas/Documents/Aox_Files/DB/${fileB%.faa}.sto ]]; then
		echo "Significant Hit Found"
        rm $newfile
		
	else #remove blank files and nonsignificant .faa files ##Significant .faa files to be compiled later...
		rm /Vagabundo/thomas/Documents/Aox_Files/DB/${fileB%.faa}.sto
		rm $newfile
	fi
done 
