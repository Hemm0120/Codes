##### this R script will produce binary distances from the
##### TIGR table of everything
    library(reshape2) ## Call Library reshape
    options(expressions=500000)

############## import the TIGR data
    data <-read.table("/Vagabundo/thomas/Documents/Graduate_Files/Research/uclust/clusters/Roles/FixedMaster.tbl", sep ="	")
    dx <- dist(data,method="binary")
    ## dx <- dist(cogtbl,method="binary") ## Create Distance matrix of the data
### Karlin's delta is normalized against number of nucleotides
#nucl <- ncol(cogtbl)
#dx = dx/nucl

#### the output file contains the distance matrix
xmat = as.matrix(dx)
write.table(xmat,
        "Distances/Bacilloma-binary.matrix",
        row.names=T,col.names=T,quote=F)
#### the output file contains the distance matrix as a table
xmat[upper.tri(xmat)] <- NA
x = melt(xmat, na.rm=T)
write.table(x, "Distances/Bacilloma-binary.tbl",
               quote=F,row.names=F,col.names=F,sep="\t")

