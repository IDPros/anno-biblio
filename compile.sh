#!/bin/bash
filename=$1
filename="${filename%.*}"  # strip off any extension
xelatex $filename
biber $filename
xelatex $filename
xelatex $filename
open $filename.pdf
