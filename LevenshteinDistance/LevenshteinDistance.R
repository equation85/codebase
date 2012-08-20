##################################################
# Levenshtein Distance
# Encoding: utf8
# Author: Frank Chen
# Last Modify: 2012/07/31 21:55:01
##################################################

### Compute Levenshtein distance between two strings
### @Param
### > source: Source string.
### > target: Target string.
### > type: Specifies the return type. 'distance' for a single distance value; 'matrix' for the matrix used during dynamic programming.
### > insert.fun, delete.fun, substitute.fun: Penalty functions of insert, delete and substitute operation, whose return value must be a single scalar value.
levenshtein.distance <- function(source, target, type=c('distance','matrix'), insert.fun=function(x) 1, delete.fun=function(x) 1, substitute.fun=function(s,t) ifelse(s==t,0,1)) {
	type <- match.arg(type)
	source.vec <- strsplit(source,'')[[1]]
	target.vec <- strsplit(target,'')[[1]]
	if(length(source.vec)==0 & length(target.vec)==0) return(0)
	if(length(source.vec)==0) return(sum(sapply(target.vec,insert.fun)))
	if(length(target.vec)==0) return(sum(sapply(source.vec,delete.fun)))
	ns <- length(source.vec) + 1
	nt <- length(target.vec) + 1
	d <- matrix(0,nrow=ns,ncol=nt,dimnames=list(c('#',source.vec),c('#',target.vec)))
	d[,1] <- 0:(ns-1)
	d[1,] <- 0:(nt-1)
	for(j in 2:nt) {
		for(i in 2:ns) {
			d[i,j] <- min( d[i-1,j] + delete.fun(source.vec[i-1]),
						   d[i,j-1] + insert.fun(target.vec[j-1]),
						   d[i-1,j-1] + substitute.fun(source.vec[i-1],target.vec[j-1]) )
		}
	}
	return( switch(type,'distance'=d[ns,nt],'matrix'=d) )
}

