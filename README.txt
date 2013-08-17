Abstract Algebra: Theory and Applications
GFDL licensed textbook
Source distribution README

This is the source distribution for the textbook.  Most of this
file describes how to create the book in different formats.

To create this text from the source requires a standard
installation of TeX/LaTeX, such as TeXLive, teTeX, MikTeX or
TeXShop.

Using  %  to comment out certain chapters in the file  aata.tex
will allow you to create an abbreviated version, though some
cross-references (index, notation) maybe missing or incorrect,
and chapter numbers will change.  Look for a group of "include"
commands that begins with "\include{sets}".  You are *required*
to keep the appendix with the GFDL license and the copyright
information at the very front.


Preliminary steps (any version)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(1) unpack the contents of the archive, this creates a new subdirectory
(2) make the new subdirectory the working directory


To create a PDF version with hyperlinked cross-references
---------------------------------------------------------
Requirements: a standard TeX distribution

(3) issue:  pdflatex aata.tex (twice!)
(4) issue:  makeindex -s aata-index-style.ist aata
(5) issue:  pdflatex aata.tex   (twice!)
(6) verify that  aata.pdf  has an "Index" entry in the Table of Contents

If you are making a PDF version of the Sage content, you may wish
to save the *.aux files for the crossreferences

Clean:  rm aata.log aata.toc aata.out aata.idx aata.ind aata.ilg *.aux


To create alternate PDF versions
--------------------------------
Look for substitute versions of aatamacros.sty to allow
for alternate ways to process the various macros embedded in
the LaTeX source.

Then follow same directions as for a PDF version.


Web page (XHTML) version
-------------------------
Requirements:  tex4ht processor to build, Firefox with math
fonts (like the Stix fonts) to view

(3) Create external tikz pictures (see below)
(4) Edit  aata.tex  and set boolean variable "xhtml" to true
    by editing the one line early on that determines the version
(5) issue:  htlatex aata "xhtml,mozilla,index=3,2" " -cmozhtf"
(6) issue:  tex '\def\filename{{aata}{idx}{4dx}{ind}} \input  idxmake.4ht'
(7) issue:  makeindex -o aata.ind  aata.4dx
(8) issue:  htlatex aata "xhtml,mozilla,index=3,2" " -cmozhtf"
(9) Result starts with  aata.xml, keep all aata*.xml

Clean:  rm aata.4dx aata.4ix idxmake.dvi idxmake.log aata.ilg aata.ind aata.4ct aata.dvi aata.idx aata.log aata.xref aata.4tc aata.css aata.idv aata.lg aata.tmp *.aux

Sage worksheet version
----------------------
Requires: tex4ht, tex2sws package

(Similar to the webpage version, but with tex2sws config file)
(3) Create external tikz pictures (see below)
(4) set boolean variable "sageworksheet" to true
    by editing the one line in aatamacros.sty that determines the version
(5) issue:  htlatex aata.tex "/full/path/to/tex4ht-sage.cfg,index=3,2" " -cunihtf -utf8"
(6) issue:  tex '\def\filename{{aata}{idx}{4dx}{ind}} \input  idxmake.4ht'
(7) issue:  makeindex -o aata.ind  aata.4dx
(8) issue:  htlatex aata.tex "/full/path/to/tex4ht-sage.cfg,index=3,2" " -cunihtf -utf8"
(9) issue:  /path/to/tex2sws.py

Result is aata.zip, a collection of Sage worksheets

Clean:  rm aata.4dx aata.4ix idxmake.dvi idxmake.log aata.ilg aata.ind aata.4ct aata.dvi aata.idx aata.log aata.xref aata.4tc aata.css aata.idv aata.lg aata.tmp *.html *.aux


Sage Content PDF, Sage Doctesting
---------------------------------
Begin with a totally clean source directory
  (external references need to be right)

(1)  pdflatex aata (twice, generates references)
(2)  pdflatex aatasage.tex
(3)  sage aatasage.sagetex.sage (to generate sage sections, doctests)
(4)  pdflatex aatasage.tex

to doctest

(4)  sage -t aatasage_doctest.sage  (use -verbose to debug doctesting)


Sage exercises, as worksheets
-----------------------------
Follow Sage worksheet version above, except

(a) In aatasage.tex set boolean variable "discussions" to false
(b) Run htlatex script as above, but on  aatasage.tex  and without  index=3
(c) Skip two index-related commands, and second htlatex run
(d) Finish with tex2sws.py script (be sure no extra CSS files are in directory)


Generating tikz pictures
~~~~~~~~~~~~~~~~~~~~~~~~
Requirements: the  mogrify  command from the  ImageMagick  suite,
gnuplot  program to generate quintic polynomial graph in  galois.tex

For PDF versions of the book, computed points for plots need to
be available to tikz (absent having gnuplot installed).  gnuplot
must be called by pdflatex, requiring the --shell-escape switch,
and the resulting computations must also be made available to
tikz for subsequent runs in the main directory. For HTML versions
of the book, versions of the graphics are needed in PNG format,
external to the source, which must be created once by tikz and
then converted to PNG format.  PDF versions of the graphics are
included in the distribution as the best-quality versions.

So this is a one-time only step, and only necessary if you

(a) edit any tikz diagrams before creating web page or Sage worksheet versions
(b) edit a tikz mathematical function computed by gnuplot as part of a tikzpicture

The mogrify command is often described as an in-place conversion,
but with the "format" switch, it will make new versions in the
requested format.  Notice also in step (4), any PDF file you leave
in that directory will not be re-generated by this process, so you
do need to move any existing files out of the way.


(3)  Edit  aata.tex  and set the version to  basic  and find
     the  externalgraphics  boolean variable and set it to true.
(4)  Create, or perhap clean-out, the  tikz  subdirectory
(5)  issue:  pdflatex -shell-escape aata.tex
(6)  move any new <file_name>.<id>.gnuplot  and  <file_name>.<id>.table files
     to main aata directory as  aata.<id>.gnuplot and aata.<id>.table
(7)  issue:  mogrify -format png -trim +repage -density 110x110 -transparent '#FFFFFF' tikz/*.pdf
(8)  delete *.log files in  tikz  subdirectory