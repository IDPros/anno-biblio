# anno-biblio
IDPro annotated bibliography

Ths system produces a formatted annotated bibliography.  It takes inputs in the form of files following the patterns provided by `biblatex`.

These are structured files which have fields for the components of the citation, such as author, date and so forth.  There is some variety in what is captured depending on the type of reference such as books, videos, web resources.

These files are correlated with some minimal control data, which is stored `.csv` files by means of a naming convention.

In addition the annotators play a prominent role.  For each annotator there is a graphic (intended to be a head shot) and a biopic.

All these elements are put together by running a shell script, `compile.sh`.

The output of the system is a `.pdf` file.  The initial setup is hard coded using U.S. Letter size pages.

A selection of fonts is intended to create a sense of light-heartedness and the materials are intended to be likewise fresh and friendly.

## Mechanism
The control files are `contributors.csv` and `contrib-cites.csv`. 
`
key,first,last,location,gtype
gdobbs,George,Dobbs,"Hartford, Connecticut, USA area",png`

As shown above the contributors file contains a unique key, the first and last name, the contributors location and a file type for the graphics.  The key is used in the names of various files, such as the graphics file, which in this case will be `gdobbs.png` which is found in the bios folder, along with `gdobbs.txt`, which contains the bio.

The second file will be explained after we look at the `.bib` files.  These are stored in the bibs folder. These are plain text files, but they can also be edited with specialty editors if desired.  Each file is contains one or more sections similar to:

![bib-sample](/Users/george/Dropbox/IDPro/BoK/anno-biblio/media/bib-sample.png)

Each contributor provides citation data and the annotation for as many items as they like in a single file under their `key`.  So this one occurs in the file named `gdobbs.bib` in the `bibs` folder.

This allows for more than one contributor to annotate the same reference.  

The citation also has a key, its the first element after the entry type, in this case, Cameron2005. 

The `contrib-cites.csv`file contains two columns, it is the mapping between the contributors and the citations.  It is currently maintained manually, but it could be generated from the `.bib` files.

## To do

1. Prepare introduction and any other front matter

2. Gather more citations.

3. Tweak the formatting 

4. Generate the contrib-cites map programatically.

5. Copy edit the existing text

6. Get some better photos
