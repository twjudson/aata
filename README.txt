Abstract Algebra: Theory and Applications
GDL licensed textbook
Source distribution README

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

(3) issue:  pdflatex aata.tex
(4) issue:  makeindex -s aata-index-style.ist aata
(5) issue:  pdflatex aata.tex   twice
(6) verify that  aata.pdf  has an "Index" entry in the Table of Contents


To create a PDF version optimized for print (Virginia Commonwealth Series)
-------------------------------------------------------------------------
Requirements: a standard TeX distribution, specialized fonts, packages;
see contents of preamble in  aata.tex  that contains VCU-specific packages

Follow same directions as for a PDF version, but after step 2, add

(2a) Edit  aata.tex  and set boolean variable "vcu" to true
     by editing the one line early on that determines the version


Web page (XHTML) version
-------------------------
Requirements:  tex4ht processor to build, Firefox with math
fonts (like the Stix fonts) to view

(3) Create external tikz pictures (see below)
(4) Edit  aata.tex  and set boolean variable "xhtml" to true
    by editing the one line early on that determines the version
(5) issue:  htlatex aata "xhtml,mozilla,index=3,2" " -cmozhtf"
(5) issue:  tex '\def\filename{{aata}{idx}{4dx}{ind}} \input  idxmake.4ht'
(7) issue:  makeindex -o aata.ind  aata.4dx
(8) issue:  htlatex aata "xhtml,mozilla,index=3,2" " -cmozhtf"
(9) Result starts with  aata.xml


Sage worksheet version
----------------------
Requires: tex4ht, nascent tex2sws package
Sketch:
    Create external graphics
    Follow webpage version, except
        (5),(8) htlatex aata.tex "/path/to/tex4ht-sage.cfg,2" " -cunihtf -utf8"
        results are html files
    Then run tex2sws converter


Generating tikz pictures
~~~~~~~~~~~~~~~~~~~~~~~~
Requirements: the  mogrify  command from the  ImageMagick  suite,
gnuplot  program to generate quintic in  galois.tex

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
requested format.


(3)  Edit  aata.tex  and set the version to  basic  and find
     the  externalgraphics  boolean variable and set it to true.
(4)  Create the <right> subdirectory, <TBD>
(5)  issue:  pdflatex -shell-escape aata.tex
(6)  move <file_name>.<id>.gnuplot  and  <file_name>.<id>.table files
     to main aata directory as  aata.<id>.gnuplot and aata.<id>.table
(7)  issue:  mogrify -format png -trim +repage -density 110x110 -transparent '#FFFFFF' graphics/tikz/*.pdf
     (this can take a while)  <sync directory here with (4)!>
(8)  delete *.log files in <directory>