### this R script will read the maximum distance matrix and produce
### a cluster with the single clustering method
library(cluster)
library(ape)

cogmat <- as.matrix(read.table("Distances_subrole/TIGR_subrole-maximum.matrix"))
## create a dendrogram using the agglomerative (bottom up) approach
## and the dx dissimilarity matrix
aggTree<-agnes(cogmat,diss=T,method="single")
aggDend<-as.hclust(aggTree)

## Output the tree in the Newick format
phy <- as.phylo(aggDend)
write.tree(phy, file="Clusters_subrole/maximum.single.newick")

## calculate the agglomerative coefficient
coeff.agg<-coef(aggTree)
coeff.agg
write(paste("maximum", "single", coeff.agg),"DATA/Coefficients.tbl",sep = "	", append=T)

