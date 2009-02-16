To create this text from the source requires a standard installation of TeX/LaTeX, such as TeXLive, teTeX, MikTeX or TeXShop.

To create a PDF version
(1) unpack the contents of the tar archive, this creates a new subdirectory
(2) make the new subdirectory the working directory
(3) issue  "pdflatex aata.tex"
(4) issue  "makeindex aata"
(5) issue  "pdflatex aata.tex" again

Using  %  to comment out certain chapters in the file  aata.tex  will allow you to create an abbreviated version, though some cross-references (index, notation) maybe missing or incorrect.  You are required to keep the appendix with the GFDL license and the copyright information at the very front.

