#!/bin/bash

PROJECT=`basename \`pwd\``
OUTPUTFILE=/usr/local/orbit/$PROJECT/data/output

if [ -f $OUTPUTFILE ]
then
	cat $OUTPUTFILE
	rm $OUTPUTFILE
fi
