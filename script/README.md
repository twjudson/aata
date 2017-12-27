# Makefile for Project Management

Read instructions in the `Makefile` which explains that `Makefile.paths.original` needs to be copied to `Makefile.paths` before this is useful.

In particular,  DO NOT EDIT

* `Makefile`
* `Makefile.paths.original`
* `Makefile.paths.example`

as their changes are managed by revision control and *will* be overwritten.

# Demonstration LaTeX to XML conversion script

The `aata-to-mathbook-xml.sed` SED script is an example of a quick-and-dirty conversion of well-formed LaTeX into Mathbook XML.  It is not offered as being at all useful as-is, but there are some ideas and techniques that may be useful for similar projects.

# Demonstration XML to XML conversion

The `consolidate.sh` shell script and the `consolidate.xsl` XSLT stylesheet were used on 2017-12-26 to resolve the multiple files and directories into 23 chapter files, plus a few others.  It also moved TikZ code out into seperate "pure text" files.  They are not meant to ever be used again, but may be instructive.
