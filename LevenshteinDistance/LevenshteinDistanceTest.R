##################################################
# Levenshtein Distance
# Encoding: utf8
# Author: Frank Chen
# Last Modify: 2012/07/31 22:04:20
##################################################

source('LevenshteinDistance.R')

levenshtein.distance.test <- function(source, target) {
	cat('Source String:',source,'\n')
	cat('Target String:',target,'\n')
	cat('Levenshtein Distance: ',levenshtein.distance(source,target),'\n')
	cat('Matrix:','\n')
	print(levenshtein.distance(source,target,'matrix'))
	cat('\n')
}

levenshtein.distance.test('kitten','sitting')
levenshtein.distance.test('Saturday','Sunday')

