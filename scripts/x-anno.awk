#!/bin/awk
#Extract the annotation fields from a .tex file
#A new file is set for each contributor-citation
#These are further processed into external annotation files for Latex (by ___)

/^@.*/ {

# we have a line with @book, @online etc
#
# oddly enough, the following line prevents too many open files
close(outfile)
#now start the logic we expect when we have a new book
split($0, parts ,"[{,]") # pull out the part between the brace and the comma
#construct the output file name
cite=parts[2]
n=split(FILENAME, parts, ".")
contributor=parts[1]
outfile="annos/" contributor "-" cite ".txt"
csvfile="annos/" contributor ".csv"# place to put the citation map for this contributor
print contributor "," cite > csvfile
print outfile
}
/annotation/{
  flag = 1
  x=index($0,"=") # throw out the label
  line=substr($0, x+1 )
  x=index(line,"{") # throw out the opening brace
  line=substr(line, x+1 )
  x=index(line,"}") # see if this is the end
  if (x > 0 ){
    line = substr(line,1,x-1)
    flag =0
  }
  print line  > outfile
}
/}/{
  if (flag == 1){
    split($0 , parts, "[}]") # throw out the brace
    print parts[1]  > outfile
    flag = 0
  }
}
/.*/ {
  if (flag == 1){ # annotation lines other than the first or last
    x=index($0,"{")
    y=index($0,"}")
    if (0==x) {
      if (0==y){
        print $0 > outfile
      }
    }
  }
}
