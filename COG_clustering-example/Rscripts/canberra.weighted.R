### this R script will read the canberra distance matrix and produce
### a cluster with the weighted clustering method
library(cluster)
library(ape)

cogmat <- as.matrix(read.table("Distances/Bacilloma-canberra.matrix"))
## create a dendrogram using the agglomerative (bottom up) approach
## and the dx dissimilarity matrix
aggTree<-agnes(cogmat,diss=T,method="weighted")
aggDend<-as.hclust(aggTree)

## Output the tree in the Newick format
phy <- as.phylo(aggDend)
write.tree(phy, file="Clusters/canberra.weighted.newick")

## calculate the agglomerative coefficient
coeff.agg<-coef(aggTree)
coeff.agg
write(paste("canberra", "weighted", coeff.agg),"DATA/Coefficients.tbl",sep = "	", append=T)

