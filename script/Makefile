## This file is part of the book                 ##
##                                               ##
##   Abstract Algebra: Theory and Applications   ##
##                                               ##
## Copyright (C) 2015-2016  Robert A. Beezer     ##
## See the file COPYING for copying conditions.  ##

#######################
# DO NOT EDIT THIS FILE
#######################

#   1) Do make a copy of Makefile.paths.original
#      as Makefile.paths
#   2) Edit Makefile.paths as directed there
#   3) This file (Makefile) and Makefile.paths.original
#      are managed by revision control and edits will conflict
#   4) See updated history in Makefile.paths.original
#      for changes, or follow the revision control history

##############
# Introduction
##############

# This is not a "true" makefile, since it does not
# operate on dependencies.  It is more of a shell
# script, sharing common configurations

# This is mostly offered as an example of one approach
# to managing a project with multiple output formats. and
# is not claimed to be "best practice"

######################
# System Prerequisites
######################

#   install         (system tool to make directories)
#   xsltproc        (xml/xsl text processor)
#   zip             (Runestone, AIM HTML builds)
#   <helpers>       (PDF viewer, web browser, pager, Sage executable, etc)

#####
# Use
#####

#	A) Set default directory to be the location of this file
#	B) At command line:  make html  (and employ targets)



# The included file contains customized versions
# of locations of the principal components of this
# project and names of various helper executables
include Makefile.paths

# These paths are subdirectories of
# the Mathbook XML distribution
# MBUSR is where extension files get copied
# so relative paths work properly
MBXSL = $(MB)/xsl
MBSCRIPT = $(MB)/pretext
MBUSR = $(MB)/user
MBDTD = $(MB)/schema/dtd

# These are source and custom XSL subdirectories
# for the two AATA repositories
SRC = $(AATA)/src
XSL = $(AATA)/xsl

# These paths are subdirectories of
# a scratch directory
HTMLOUT    = $(SCRATCH)/html
PDFOUT     = $(SCRATCH)/pdf
DOCTEST    = $(SCRATCH)/doctest
JUPYTEROUT = $(SCRATCH)/jupyter
BRAILLEOUT = $(SCRATCH)/braille

# These levels need to go into a publisher file, once that
# prospect is implemented.  For now, we economize with a
# string, these match "xsl/aata-common.xsl"
LEVELS=numbering.theorems.level 1 numbering.equations.level 1 numbering.footnotes.level 0 numbering.maximum.level 2

# useful date string
# http://stackoverflow.com/questions/1401482
DATE=$(shell date +%Y-%m-%d)

# zipfiles AIM/UTMOST study, Runestone version
ZIPAIM=aata-html-$(DATE).zip
ZIPRS=AATA-runestone-$(DATE).zip


# convenience for rsync command, hopefully not OS dependent
# First does not include  --delete  switch at end due to PDF in directory
# Second makes *exact* mirror of build directory
RSYNC=rsync --verbose  --progress --stats --compress --rsh=/usr/bin/ssh --recursive
RSYNCDELETE=rsync --verbose  --progress --stats --compress --rsh=/usr/bin/ssh --recursive --delete

###############
# Preliminaries
###############

# Diagrams
#   invoke mbx script to manufacture diagrams
#   tikz as SVG for HTML
#   sageplot as PDF for LaTeX, SVG for HTML
#   these outputs are in source repo now, and
#   are typically just copied out
#   this should be run if diagram source changes
#   NB: targets below copy versions out of repo and clobber these
diagrams:
	install -d $(HTMLOUT)/images
	-rm $(HTMLOUT)/images/*
	$(MBSCRIPT)/pretext -v -c latex-image -f svg -d $(HTMLOUT)/images $(SRC)/aata.xml
	$(MBSCRIPT)/pretext -v -c sageplot    -f pdf -d $(HTMLOUT)/images $(SRC)/aata.xml
	$(MBSCRIPT)/pretext -v -c sageplot    -f svg -d $(HTMLOUT)/images $(SRC)/aata.xml


##########
# Products
##########

# HTML version
#   Copies in image files from source directory
#   Publisher file is a relative path to master source file
#   Move to server: generated *.html and
#   entire directories - /images and /knowl
html:
	install -d $(HTMLOUT) $(MBUSR)
	cp -a $(SRC)/images $(HTMLOUT)
	cp $(XSL)/aata-common.xsl $(XSL)/aata-html.xsl $(MBUSR)
	cd $(HTMLOUT); \
	xsltproc -xinclude -stringparam publisher ../publisher/public.xml $(MBUSR)/aata-html.xsl $(SRC)/aata.xml

viewhtml:
	$(HTMLVIEWER) $(HTMLOUT)/aata.html &

# Full PDF version with Sage
#   copies in all image files, which is overkill (SVG's)
#   produces  aata-sage.tex  in scratch directory
#   which becomes PDF, along with index entries
#   Includes *all* material, and is fully electronic
#   This is the AATA/Sage downloadable Annual Edition
sage:
	# delete old  xsltproc  output
	# dash prevents error if not found
	-rm $(PDFOUT)/aata.tex
	install -d $(PDFOUT) $(MBUSR)
	cp -a $(SRC)/images $(PDFOUT)
	cp $(XSL)/aata-common.xsl $(XSL)/aata-latex.xsl $(XSL)/aata-sage.xsl $(MBUSR)
	cd $(PDFOUT); \
	xsltproc -o aata.tex --xinclude $(MBUSR)/aata-sage.xsl $(SRC)/aata.xml; \
	$(ENGINE) aata.tex; $(ENGINE) aata.tex; \
	mv aata.pdf aata-sage.pdf

# View PDF from correct directory
viewsage:
	$(PDFVIEWER) $(PDFOUT)/aata-sage.pdf &

# Electronic PDF version
#   copies in all image files, which is overkill (SVG's)
#   produces  aata-electronic.tex  in scratch directory
#   which becomes PDF, along with index entries
#   Similar to "print" but with links, etc.
#   No Sage material
#   This is default downloadable Annual Edition
#   ie, aata-YYYYMMDD.pdf in repository download section
electronic:
	# delete old  xsltproc  output
	# dash prevents error if not found
	-rm $(PDFOUT)/aata.tex
	install -d $(PDFOUT) $(MBUSR)
	cp -a $(SRC)/images $(PDFOUT)
	cp $(XSL)/aata-common.xsl $(XSL)/aata-latex.xsl $(XSL)/aata-electronic.xsl $(MBUSR)
	cd $(PDFOUT); \
	xsltproc -o aata.tex --xinclude $(MBUSR)/aata-electronic.xsl $(SRC)/aata.xml; \
	$(ENGINE) aata.tex; $(ENGINE) aata.tex; \
	mv aata.pdf aata-electronic.pdf

# View PDF from correct directory
viewelectronic:
	$(PDFVIEWER) $(PDFOUT)/aata-electronic.pdf &

# Print PDF version
#   A print version for print-on-demand
#   This will be source for the Annual Edition,
#     as sent to Orthogonal Publishing for modification
#   Black on white, no live URLs, etc
#   This is the "printable" downloadable Annual Edition
print:
	# delete old  xsltproc  output
	# dash prevents error if not found
	-rm $(PDFOUT)/aata.tex
	install -d $(PDFOUT) $(MBUSR)
	cp -a $(SRC)/images $(PDFOUT)
	cp $(XSL)/aata-common.xsl $(XSL)/aata-latex.xsl $(XSL)/aata-print.xsl $(MBUSR)
	cd $(PDFOUT); \
	xsltproc -o aata.tex --xinclude $(MBUSR)/aata-print.xsl $(SRC)/aata.xml; \
	$(ENGINE) aata.tex; $(ENGINE) aata.tex; \
	mv aata.pdf aata-print.pdf

# View PDF from correct directory
viewprint:
	$(PDFVIEWER) $(PDFOUT)/aata-print.pdf &

# Runestone HTML
#   Modeled on raw HTML
#   Will produce a zip file
#   SOME TOTALLY HARDCODED PATHS
runestone:
	install -d $(HTMLOUT) $(MBUSR) $(HTMLOUT)/_static
	cp -a $(SRC)/images $(HTMLOUT)
	cp $(XSL)/aata-common.xsl $(XSL)/aata-html.xsl $(MBUSR)
	cp /home/rob/mathbook/python-virtual/env/lib/python3.6/site-packages/runestone/dist/runestone.js $(HTMLOUT)/_static
	cp /home/rob/mathbook/python-virtual/env/lib/python3.6/site-packages/runestone/common/js/jquery.idle-timer.js $(HTMLOUT)/_static
	cd $(HTMLOUT); \
	xsltproc --xinclude -stringparam publisher ../publisher/runestone.xml $(MBUSR)/aata-html.xsl $(SRC)/aata.xml; \
	zip -r $(SCRATCH)/$(ZIPRS) .

# LEVELS should go away in favor of a publisher file
# This elects embossable format, easy to clone for braille-electronic
braille:
	install -d $(BRAILLEOUT)
	$(MBSCRIPT)/pretext -vv -c all -f braille-emboss -x $(LEVELS) -d $(BRAILLEOUT) $(SRC)/aata.xml


######
# Sage
######

# AATA has extensive support for Sage
# These targets are all related to that

# Doctest
#   All Sage material, but not solutions to exercises
#   Prepare location, remove *.py from previous runs
#   XSL dumps into current directory, Sage processes whole directory
#   chunk level 2 gives sections (commentaries, exercises)
doctest:
	-rm $(DOCTEST)/*.py; \
	install -d $(DOCTEST)
	cd $(DOCTEST); \
	xsltproc --xinclude --stringparam chunk.level 2 $(MBXSL)/pretext-sage-doctest.xsl $(SRC)/aata.xml; \
	$(SAGE) -tp 0 .

##############
# Experimental
##############

# These are in-progress and/or totally broken

# Jupyter Notebooks - experimental
jupyter:
	install -d $(JUPYTEROUT) $(MBUSR)
	cp -a $(SRC)/images $(JUPYTEROUT)
	cp $(XSL)/aata-common.xsl $(XSL)/aata-jupyter.xsl $(MBUSR)
	cd $(JUPYTEROUT); \
	xsltproc --xinclude $(MBUSR)/aata-jupyter.xsl $(SRC)/aata.xml

# This makes a zip file of a version for use at AIM Books
# Clean out directories first by hand
# Date and upload
# HTML version
#   Copies in image files from source directory
aimhtml:
	install -d $(HTMLOUT) $(MBUSR)
	cp -a $(SRC)/images $(HTMLOUT)
	cp $(XSL)/aata-common.xsl $(XSL)/aata-html.xsl $(MBUSR)
	cd $(HTMLOUT); \
	xsltproc -xinclude -stringparam publisher ../publisher/AIM-test-sites.xml $(MBUSR)/aata-html.xsl $(SRC)/aata.xml
	mv $(SCRATCH)/html $(SCRATCH)/aata-html
	cd $(SCRATCH); \
	zip -r $(ZIPAIM) aata-html/
	${RSYNCDELETE} $(SCRATCH)/${ZIPAIM} utmost@utmost.aimath.org:/home/utmost/www/pretextbook.org/htdocs/beta
	echo "Dropped in http://pretextbook.org/beta/"${ZIPAIM}
