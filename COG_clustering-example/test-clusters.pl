#!/usr/bin/env perl
## Set Variables
my $distances_dir = "Distances";
my $clusters_dir  = "Clusters";
my $r_scripts     = "Rscripts";
for my $dir2make ( "$distances_dir", "$clusters_dir", "$r_scripts" ) {
    unless( -d "$dir2make" ) {
        mkdir("$dir2make");
    }
}

## Distance Methods
my @dist_methods = qw(
                         euclidean
                         maximum
                         manhattan
                         canberra
                         binary
            );
## Type of linkage anaylsis
my @agg_methods = qw(
                        average
                        single
                        complete
                        ward
                        weighted
                );

system "rm DATA/Coefficients.tbl"; ## Remove any old results
for my $dist_method ( @dist_methods ) { ## For each Distance method
    print $dist_method,"\n"; ## Pritn the method name
    build_distR("$dist_method"); ##
    system("R --vanilla <$r_scripts/$dist_method.R");
    for my $clust_method ( @agg_methods ) {
        build_clust_R("$dist_method","$clust_method");
        system("R --vanilla <$r_scripts/$dist_method.$clust_method.R");
    }
}

sub build_distR {
    my $dist = $_[0];
    print "working with $dist ($r_scripts/$dist.R)\n";
    open( my $DISTR,">","$r_scripts/$dist.R" );
    print {$DISTR} << "DISTR";
    ##### this R script will produce $dist distances from the
    ##### COG table of the Bacillomas
    library(reshape2)
    
    ############## import the COG data
    cogtbl<-read.table("DATA/Baciloma_COGs_count.tbl")
    
    ############## calculate the distance matrix
    dx <-read.table("/Vagabundo/thomas/Documents/Graduate_Files/Research/uclust/clusters/Roles/FixedMaster.tbl", sep ="\t")
    ## dx <- dist(cogtbl,method="$dist") ## Create Distance matrix of the data
### Karlin's delta is normalized against number of nucleotides
#nucl <- ncol(cogtbl)
#dx = dx/nucl

#### the output file contains the distance matrix
xmat = as.matrix(dx)
write.table(xmat,
        "$distances_dir/Bacilloma-$dist.matrix",
        row.names=T,col.names=T,quote=F)
#### the output file contains the distance matrix as a table
xmat[upper.tri(xmat)] <- NA
x = melt(xmat, na.rm=T)
write.table(x, "$distances_dir/Bacilloma-$dist.tbl",
               quote=F,row.names=F,col.names=F,sep="\\t")

DISTR
    close($DISTR);
}

sub build_clust_R {
    my($dist,$method) = @_;
    print "working with $method ($r_scripts/$dist.$method.R)\n";
    open( my $CLUSTR,">","$r_scripts/$dist.$method.R" );
    print {$CLUSTR} << "CLUSTR";
### this R script will read the $dist distance matrix and produce
### a cluster with the $method clustering method
library(cluster)
library(ape)

cogmat <- as.matrix(read.table("$distances_dir/Bacilloma-$dist.matrix"))
## create a dendrogram using the agglomerative (bottom up) approach
## and the dx dissimilarity matrix
aggTree<-agnes(cogmat,diss=T,method="$method")
aggDend<-as.hclust(aggTree)

## Output the tree in the Newick format
phy <- as.phylo(aggDend)
write.tree(phy, file="$clusters_dir/$dist.$method.newick")

## calculate the agglomerative coefficient
coeff.agg<-coef(aggTree)
coeff.agg
write(paste("$dist", "$method", coeff.agg),"DATA/Coefficients.tbl",sep = "\t", append=T)

CLUSTR
    close($CLUSTR);
}
