#!/bin/bash
filename=$1
filename="${filename%.*}"  # strip off any extension

# refresh the annotation files
# the .bib files are the source
cd bibs # outputs files into annos folder below bibs
awk -f x-anno.awk *.bib

# regenerate the contrib-cites map
head -n 1  ../contrib-cites.csv > annos/_.csv #grep the header
cat annos/*.csv > ../contrib-cites.csv #put all into one file
rm annos/*.csv #clean up
cd ..

# xelatex allows for modern fonts and unicode
xelatex $filename # first run to prepare for biber
biber $filename
xelatex $filename  # don't recall why there are two more, but it is needed.
xelatex $filename
open $filename.pdf
