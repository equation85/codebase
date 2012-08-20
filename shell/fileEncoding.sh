#!/usr/bin/env bash
# Encoding: utf8
# Author: Frank Chen<frank85chen@gmail.com>
# Description: Convert a bunch of files from one encoding to another

FROM_ENCODING=""
TO_ENCODING=""

function print_help {
	echo "Use case:"
	echo "  $ ls | fileEncoding -f utf8 -t gbk"
	echo "It will change the encoding of files returned by 'ls' from utf8 to gbk"
}

while getopts ":f:t:h" optname
do
	case "$optname" in
	"f")
		FROM_ENCODING=$OPTARG
		;;
	"t")
		TO_ENCODING=$OPTARG
		;;
	*)
		print_help
		exit 1
		;;
	esac
done

while read line
do
	iconv -f $FROM_ENCODING -t $TO_ENCODING $line > "$line.$TO_ENCODING"
done

