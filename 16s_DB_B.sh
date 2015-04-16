cd /Vagabundo/thomas/Documents/fna-Genome #Parent Directory of subdirectories containing fasta.tgz files

var=".fna.bz2" #Substring to look for at end of string (file) 
echo "Stage One"
for file in *; do
	bunzip2 -c /Vagabundo/thomas/Documents/fna-Genome/$file > /Vagabundo/thomas/Documents/16sb/${file%.bz2}
    echo "Processing...:"
done
echo "Stage Two"
cd  /Vagabundo/thomas/Documents/16s
for fileB in *; do #for extracted files..
	newfile="/Vagabundo/thomas/Documents/16sb/$fileB" #newfile = one of the fna files
	/Vagabundo/thomas/bin/hmmsearch -A /Vagabundo/thomas/Documents/16sb/${fileB%.fna}.sto -E 1e-6 /Vagabundo/thomas/Downloads/rRNASelector_for_linux/lib/16s_bact_rev3.hmm $newfile ##Hmmsearch newfiles vs. 16s HMM
	
	if [[ -s /Vagabundo/thomas/Documents/16sb/${fileB%.fna}.sto ]]; then
		echo "Significant Hit Found"
        rm /Vagabundo/thomas/Documents/16sb/${fileB%.fna}.sto
		
	else #remove blank files and nonsignificant .fna files ##Significant .fna files to be compiled later...
		rm /Vagabundo/thomas/Documents/16sb/${fileB%.fna}.sto
		rm $newfile
	fi
done 
