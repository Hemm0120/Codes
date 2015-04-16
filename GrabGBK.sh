#!/bin/sh

# GrabGBK.sh
# 
#

cd /Winnebago/thomas/Documents/draft/ ## Folder containing subdirectories with significant matches 
for file in *; do ## For each subdirectory
	cd /research/gmh/GENOME_DB/DownLoad/biomirror/ncbigenomes/Bacteria_DRAFT/$file/ ## cd to corresponding Draft folder
	for fileB in *; do ## for each file in each significant folder
		if [ ${fileB: - 7} == "gbk.tgz" ] ## if the file end with gbk.tgz
		then
			cd /Winnebago/thomas/Documents/draft/$file/ ## cd to the subdirectory containing .sto matches
			tar -zxvf /research/gmh/GENOME_DB/DownLoad/biomirror/ncbigenomes/Bacteria_DRAFT/$file/$fileB ##Untar the .gbk.tgz filecd
		fi 
	done
done