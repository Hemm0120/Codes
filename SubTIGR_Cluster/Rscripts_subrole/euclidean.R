##### this R script will produce euclidean distances from the
##### TIGR table of everything
    library(reshape2) ## Call Library reshape
    options(expressions=500000)

############## import the TIGR data
    data <-read.table("/Vagabundo/thomas/Documents/Graduate_Files/Research/uclust/clusters/Subroles/FixedMaster.tbl", sep ="\t")
    dx <- dist(data,method="euclidean")
    ## dx <- dist(cogtbl,method="euclidean") ## Create Distance matrix of the data
### Karlin's delta is normalized against number of nucleotides
#nucl <- ncol(cogtbl)
#dx = dx/nucl

#### the output file contains the distance matrix
xmat = as.matrix(dx)
write.table(xmat,
        "Distances_subrole/TIGR_subrole-euclidean.matrix",
        row.names=T,col.names=T,quote=F)
#### the output file contains the distance matrix as a table
xmat[upper.tri(xmat)] <- NA
x = melt(xmat, na.rm=T)
write.table(x, "/TIGR_subrole-euclidean.tbl",
               quote=F,row.names=F,col.names=F,sep="\t")

