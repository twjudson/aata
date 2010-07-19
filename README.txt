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
Requirements: a standard TeX distribution, speciallized fonts, packages;
see contetns of VCU-specific preamble in  aata.tex

Follow same directions as for a PDF version, but after step 2, add
(2a) Edit  aata.tex  and set boolean variable "vcu" to true
by editing the one line early on that determines the version


Web page (XHTML) version
-------------------------
Requirements:  tex4ht processor to build, Firefox with math
fonts (like the Stix fonts) to view

(3) Edit  aata.tex  and set boolean variable "xhtml" to true
by editing the one line early on that determines the version
(4) issue:  htlatex aata "xhtml,mozilla,index=3,2" " -cmozhtf"
(5) isuue:  tex '\def\filename{{aata}{idx}{4dx}{ind}} \input  idxmake.4ht'
(6) issue:  makeindex -o aata.ind  aata.4dx
(7) issue:  htlatex aata "xhtml,mozilla,index=3,2" " -cmozhtf"
(8) Result starts with  aata.xml
