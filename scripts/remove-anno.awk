#!/bin/awk
#Remove the annotation fields from a .tex file
#create an annotation-free file in folder ../bibs-no-anno
#(The annotations will have been already extracted into external files)
#expected to run in the bibs folder

# for all lines
/.*/ {

#construct the output file name
n=split(FILENAME, parts, "/") # remove the path
outfile="../bibs-no-anno/" parts[n]


if (match($0,"^[ \t]*annotation")){ # set flag if we see annotation
  flag = 1
}

if (flag == 0){  # print the line if not in the annotation
  print $0 > outfile
  }
}

#look for the end of the annotation
/}/{
  if (flag == 1){
    flag = 0
  }
}

END {close outfile}

