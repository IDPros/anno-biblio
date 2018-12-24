#!/bin/bash
filename=$1
filename="${filename%.*}"  # strip off any extension

# refresh the annotation files
# the .bib files are the source
cd bibs # outputs files into annos folder below bibs
awk -f x-anno.awk *.bib
cd ..

# xelatex allows for modern fonts and unicode
xelatex $filename # first run to prepare for biber
biber $filename
xelatex $filename  # don't recall why there are two more, but it is needed.
xelatex $filename
open $filename.pdf
