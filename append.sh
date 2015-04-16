cd /Vagabundo/thomas/Documents/16s/
for file in *; do
	cd /Winnebago/thomas/Documents/draft/$file/ #CD to Subdirectory
	for fileA in *; do
			cat $fileA >> /Winnebago/thomas/Documents/SignificantDraft.sto
	done
done 