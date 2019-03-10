#!/bin/bash
# produces a tex file to include in the compilation
# this combines the graphic, the bios and the recommendations in the correct order
# the output can be edited to fix pagination glitches, for instance
# but it will be overwritten at the next run of this program.
# this program should be run in the project root
# where it will find the csv files it needs
# the output file is recommends.tex

contribs='contributors.csv'
ccites='contrib-cites.csv'
outfile='recommends.tex'
slash="/"
subfirst="s/\first/"

[ ! -f $contribs ] && echo $contribs " not found." && exit 1
[ ! -f $ccites ] && echo $ccites " not found." && exit 1

[ -f $outfile ] && rm $outfile  # remove old output file

tx="\subsection{\first~\last} \
    \textsf{\area} \par \
    \setlength{\columnsep}{0pt} \
    \begin{wrapfigure}{l}{0.25\textwidth} \
        \centering \
       \includegraphics[width=0.18\textwidth]{bios/\key.\gtype} \
    \end{wrapfigure} \
    \input{bios/\key.txt} \
    \subsubsection{Recommendations}\begin{enumerate}"
citeitem="\item \cite{\citation}"
endenum="\end{enumerate}\noindent\rule{\textwidth}{0.2pt}"

# all but the header line of the contributors
tail -n +2 $contribs | \
while read line; do
  key=`echo $line | awk -F ',' '{print $1}'`
  first=`echo $line | awk -F ',' '{print $2}'`
  last=`echo $line | awk -F ',' '{print $3}'`
  area=`echo $line | awk '{n=split($0, parts, "\"");print parts[2]}'`
  gtype=`echo $line | awk -F ',' '{print $NF}'`
  gtype=`echo $gtype | tr -d '\r'` # remote the carriage return - screws up sed

  echo $tx | sed "s/\\\\first/$first/" \
    | sed "s/\\\\last/$last/" \
    | sed "s/\\\\key/$key/g" \
    | sed "s/\\\\area/$area/" \
    | sed "s/\\\\gtype/$gtype/" \
    >> $outfile

  # get the citations
  skey='^'$key
  grep $skey $ccites | awk -F ',' '{print $2}' | sort | \
  while read citation; do
    echo $citeitem | sed "s/\\\\citation/$citation/" >> $outfile
  done
  echo $endenum >> $outfile
  echo "" >> $outfile

done
