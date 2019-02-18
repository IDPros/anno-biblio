#!/bin/bash
# combine the annotation files from annos folder by citation
# put in project root acording to biblatex naming convention
# someday find a way to put them elsewhere
# Assume to be run in project root

slash="/"
src="bibs/annos/"
base="bibannotation-"
rm $base*  #clean out old ones because all writes are >> (additive)

for f in $src*.txt
do
# get the citation part of the file name
# it might have a hyphen in it so loop
  a=`echo $f | awk -F '-' '{for(i=2;i<=NF;i++){ printf("%s",( (i>2) ? "-" : "" ) $i) };print "" ;}'| sed 's/txt/tex/' `
  cat $f >> $base$a  # copy the contents

  echo $f " --> " $base$a

  #lookup the name from the contributor key
  k=`echo $f | awk -F '-' '{print $1}'` #drop the citation and file extension
  k=`echo $k | awk -F $slash '{print $NF}'` # drop the path
  entry=`grep "^$k" contributors.csv` # get the row starting with the key
  first=`echo $entry | awk -F ',' '{print $2}'`
  last=`echo $entry | awk -F ',' '{print $3}'`

  #wrap with a format for tex (escape the back slashes)
  format="\\setlength{\\parindent}{0cm}\\par\\textsc{"
  end="}\\par\\vspace{12pt}\\setlength{\\parindent}{15pt}"
  echo $format "---" $first $last $end >> $base$a
done
