### this R script will read the euclidean distance matrix and produce
### a cluster with the complete clustering method
library(cluster)
library(ape)

cogmat <- as.matrix(read.table("Distances_subrole/TIGR_subrole-euclidean.matrix"))
## create a dendrogram using the agglomerative (bottom up) approach
## and the dx dissimilarity matrix
aggTree<-agnes(cogmat,diss=T,method="complete")
aggDend<-as.hclust(aggTree)

## Output the tree in the Newick format
phy <- as.phylo(aggDend)
write.tree(phy, file="Clusters_subrole/euclidean.complete.newick")

## calculate the agglomerative coefficient
coeff.agg<-coef(aggTree)
coeff.agg
write(paste("euclidean", "complete", coeff.agg),"DATA/Coefficients.tbl",sep = "	", append=T)

