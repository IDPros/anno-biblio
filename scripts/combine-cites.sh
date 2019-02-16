#!/bin/bash
# combine the annotation files from annos folder by citation
# put in project root acording to biblatex naming convention
# someday find a way to put them elsewhere
# Assume to be run in bibs/annos

base="../../bibannotation-"
rm $base*  #clean out old ones because all writes are >> (additive)

for f in *.txt
do
  echo $f
  a=`echo $f | awk -F '-' '{print $2}'| sed 's/txt/tex/' `  # the citation part of the file name
  cat $f >> $base$a  # copy the contents

  #lookup the name from the contributor key
  k=`echo $f | awk -F '-' '{print $1}'`
  entry=`grep "$k" ../../contributors.csv`
  first=`echo $entry | awk -F ',' '{print $2}'`
  last=`echo $entry | awk -F ',' '{print $3}'`

  #wrap with a format for tex (escape the back slashes)
  format="\\\\\\vspace{24pt}{\\setlength{\\parindent}{0cm}\\textsc{"
  end="}}"
  echo $format "---" $first $last $end >> $base$a
done
