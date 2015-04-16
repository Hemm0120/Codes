cd /Vagabundo/thomas/Documents/Graduate_Files/Research/uclust/clusters/Subroles
head -1 Master.txt | cut -f 3-20,24-25 > Fixedheader.tbl
cut -f 1,3-20,24-25 Master.txt | tail -n +2 > FixedBodyMaster.tbl 
cat Fixedheader.tbl FixedBodyMaster.tbl > FixedMaster.tbl
