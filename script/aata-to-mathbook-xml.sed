#
# A sed script to convert Structured LaTeX into MathBook XML
#
# Rob Beezer <beezer@ups.edu>
#
# 2013/09/27  Updates for MathBook changes
# 2014/05/21  EAGTS's "Structured LaTeX into MathBook XML"
#             Heavily edited for AATA cutover
#             (**) indicate subsequent systematic editing
#

# Do minor, atomic stuff first, changes are cumulative
# For example, fix angle brackets before writing more
# Do math inside captions, titles, before writing wrappers

# Preliminary fix for boldemph broken across lines
# http://stackoverflow.com/questions/9605232/merge-two-lines-into-one
# Not always successful, for an unknown reason
/boldemph{\([^}]*\)$/ {N; s/\n/ /}

# Protect TeX math and double-dash in tikz diagrams
/tikzpreface/,/end{tikzpicture/ {s/\$/XXXTIKZDOLLARXXX/g}
/tikzpreface/,/end{tikzpicture/ {s/--/XXXTIKZDASHXXX/g}

# Protect ampersands in matrices
/begin{pmatrix/,/end{pmatrix/ { s/&/XXXMATRIXAMPXXX/g }

####
#
# Math
#
####

# Less than, <
# Always " < " in math
# Fixed exceptions with variants of  grep -n "<[^ ]" *.tex
# So can simply match on " < "
s/ < / \\lt /g

# Greater than, >
# Almost always " > " in math
# Fixed exceptions with variants of  grep -n ">[^ ]" *.tex
# So can simply match on " > "
s/ > / \\gt /g

# Inline math is in paired $'s
# (**) many $-pairs cross line boundaries
# Could not get multi-line sed to correct these
s/\$\([^$]*\)\$/<m>\1<\/m>/g

# Roughly 450 matrices, all pmatrix environments
# Wrap in CDATA so not so many &amp;
s/\\begin{pmatrix}/\\begin{pmatrix}<![CDATA[/g
s/\\end{pmatrix}/]]>\\end{pmatrix}/g

# math displays are surrounded by \[, \] on lines of their own
# Some spurious whitespace at end of lines messes this up
# All fixed via: grep -n "^[\\ ]*\\\\\\]." *.tex
# Could not get sed to make these tight due to
# some interference in pmatrix/CDATA/ampersand conversions
s/^[\ ]*\\\[$/<me>/g
s/^[\ ]*\\\]$/<\/me>/g

# multiple row math displays
# align * and gather* environments
# </mrow><mrow> to replace \\ breaks
# (**) will need reformatting
/\\begin{align\*}/,/\\end{align\*}/ { s/\s\\\\/<\/mrow><mrow>/g}
/\\begin{gather\*}/,/\\end{gather\*}/ { s/\s\\\\/<\/mrow><mrow>/g}
s/\\begin{align\*}/<md><mrow>/g
s/\\end{align\*}/<\/mrow><\/md>/g
s/\\begin{gather\*}/<md><mrow>/g
s/\\end{gather\*}/<\/mrow><\/md>/g

####
#
# Minor TeX'isms
#
####

# TeX left/right double quotes
# Apparently no single quoates:  grep "[^\`]\`[^\`]" *.tex
#
s/``/<q>/g
s/''/<\/q>/g

# TeX dashes
# Convert to ndash before writing comments
# triple dash first
#
s/---/<mdash \/>/g
s/--/<ndash \/>/g

# \textbf
# (a)  Theorem titles edited
# (b)  Remark environment substituted
# (c)  \item[\textbf{[2]}] converted to biblio
# (d)  grep "[^[]\\\\textbf" *.tex  shows 8 remarks, 40 more, mostly in biblios

# Footnotes
# eg, \footnote{....
# Mostly have line breaks, so need hand-editing to place
s/\\footnote/<footnote>FIXME: Move content in here<\/footnote>/g

# Inline code for Sage
# eg, \verb?side?
s/\\verb?\([^?]*\)?/<c>\1<\/c>/g


####
#
# Environments
#
####

# Example
# eg, \begin{example}{Cyclic_Z3}
# always with a label
# (**) two or three examples with empty labels
s/\\begin{example}{\([^}]*\)}/<example xml:id="\1">\n<p>/g
s/\\end{example}/<\/p>\n<\/example>/g

# (**) "Theorem" type environments will need to enclose any subsequent proof

# Theorem
# (a) Title, then label, first
# (b) Label only, second
# (c) Title only, third
# (d) Plain, last
s/\\begin{theorem}\[\([^]]*\)\]\\label{\([^}]*\)}/<theorem xml:id="\2">\n<title>\1<\/title>\n<statement>\n<p>/g
s/\\begin{theorem}\\label{\([^}]*\)}/<theorem xml:id="\1">\n<statement>\n<p>/g
s/\\begin{theorem}\[\([^]]*\)\]/<theorem>\n<title>\1<\/title>\n<statement>\n<p>/g
s/\\begin{theorem}/<theorem>\n<statement>\n<p>/g
s/\\end{theorem}/<\/p>\nFIXME-MOVE-IN-PROOF<\/statement>\n<\/theorem>/g

# Lemma
# same strategy as Theorem above
# (a) Title, then label
# (b) Label
# (c) Plain
s/\\begin{lemma}\[\([^]]*\)\]\\label{\([^}]*\)}/<lemma xml:id="\2">\n<title>\1<\/title>\n<statement>\n<p>/g
s/\\begin{lemma}\\label{\([^}]*\)}/<lemma xml:id="\1">\n<statement>\n<p>/g
s/\\begin{lemma}/<lemma>\n<statement>\n<p>/g
s/\\end{lemma}/<\/p>\nFIXME-MOVE-IN-PROOF<\/statement>\n<\/lemma>/g

# Corollary
# same strategy as above
# (a) Label
# (b) Plain
s/\\begin{corollary}\\label{\([^}]*\)}/<corollary xml:id="\1">\n<statement>\n<p>/g
s/\\begin{corollary}/<corollary>\n<statement>\n<p>/g
s/\\end{corollary}/<\/p>\nFIXME-MOVE-IN-PROOF<\/statement>\n<\/corollary>/g

# Proposition
# same strategy as Theorem above
# (a) Title, no label
# (b) Label
# (c) Plain
s/\\begin{proposition}\[\([^]]*\)\]/<proposition>\n<title>\1<\/title>\n<statement>\n<p>/g
s/\\begin{proposition}\\label{\([^}]*\)}/<proposition xml:id="\1">\n<statement>\n<p>/g
s/\\begin{proposition}/<proposition>\n<statement>\n<p>/g
s/\\end{proposition}/<\/p>\nFIXME-MOVE-IN-PROOF<\/statement>\n<\/proposition>/g

# Proof
# w/ initial paragraph
s/\\begin{proof}/<proof><p>/g
s/\\end{proof}/<\/p><\/proof>/g

# Remark
# (**) Need to manually move in content
s/\\noindent \\textbf{Remark.}/<remark>\n<p>FIXME-MOVE-IN-REMARK<\/p>\n<\/remark>/g

# History boxes
# (**) FIXME will indicate an extra }
# 18:  grep -n "histf" *.tex (one in macros.tex)
# 18:  grep "histbox" *.tex | wc  (-A 1 shows } after each)
/\histhead/d
s/\\noindent{\\small \\histf/<historical>\n<p>/g
s/\\small \\histf/<historical>\n<p>/g
s/\\histbox/<\/p>\n<\/historical>  <!-- FIXME: stray closing brace on next line -->/g

# Sage Exercises
# Do this before  sageverbatim  replacements below
# And prior to general comment lines
# eg, \sageexercise{1}%  to start (w, w/o %)
# eg, \begin{sageverbatim}\end{sageverbatim}  to end
s/\\sageexercise{\([^}]*\)}%/<exercise number="\1">\n<statement>\n/g
s/\\sageexercise{\([^}]*\)}/<exercise number="\1">\n<statement>\n/g
s/\\begin{sageverbatim}\\end{sageverbatim}/\n<\/statement>\n<sage \/>\n<\/exercise>/g


# Sage Code
# (**) May require moving output lines, and/or replicating for several outputs
s/\\begin{sageexample}/<sage>\n<input>/g
s/\\end{sageexample}/<\/input>\n<output>\n<\/output>\n<\/sage>/g
s/\\begin{sageverbatim}/<sage>\n<input>/g
s/\\end{sageverbatim}/<\/input>\n<output>\n<\/output>\n<\/sage>/g

####
#
# Figures
#
####

# Caption
# (**) Captions can have math with braces
# so cannot be certain about first right brace
# This will break if there is LaTeX using braces
# eg \caption{Subgroups of <m>S_3</m>}
s/\\caption{\([^}]*\)}/<caption>\1<\/caption>/g


# (**) \label{} contents for figures will need to move to xml:id manually
# Environment
# eg, \begin{figure}[htb], or w/o []
s/\\begin{figure}\[\([^]]*\)\]/<figure xml:id="">\n/g
s/\\begin{figure}/<figure xml:id="">\n/g
s/\\end{figure}/<\/figure>\n/g

# tikz wrapper
# eg, \tikzpreface{cyclic_s3_subgroups}
# CDATA needed for lines and arrows, eg [<-]
# (**) $-math syntax will get mangled and need to be redone
s/\\tikzpreface{\([^}]*\)}/<tikz filebase="\1"><![CDATA[/g
s/\\end{tikzpicture}/\\end{tikzpicture}]]>\n<\/tikz>/g

####
#
# Miscellaneous
#
####

# Labels
# (**) colon and caret are illegal characters in XML id's

# Cross-references
# (**) grep shows 8 \ref w/o ~
s/~\\ref{\([^}]*\)}/<nbsp \/><xref ref="\1" \/>/g

# Citations
# (**) About 10-15 hard-coded citation numbers:  grep " \[[0-9]*\]" *.tex
# No "\cite" anywhere

# References in chapter Reading lists
# (**) will need xml:id for xref citations from above
# eg, \item[\textbf{[1]}].....
s/\\item\[\\textbf{\[\([^]]*\)\]}\]/<\/biblio>\n<biblio type="raw"> <!-- was [\1] -->\n/g

# Defined terms
# (**) 171 have intermediate line break
# grep  "\\\\boldemph{[^}]*$" *.tex
s/\\boldemph{\([^}]*\)}/<term>\1<\/term>/g

# Emphasis
# eg, \emph{Cyclic Subgroups}
s/\\emph{\([^}]*\)}/<em>\1<\/em>/g

# Notation
# (**) notation.tex, 100 \pageref; grep "pageref" *.tex
# 51 labels look like \label{\note....}; grep \\\\label{note" *.tex

# File header
# Replace all of line 1 w/ XML stuff and license info
# Judson book header, Beezer Sage header
1 s/^.*$/<?xml version="1.0" encoding="UTF-8" ?>\n\n<!-- This file is part of the book                 -->\n<!--                                               -->\n<!--   Abstract Algebra: Theory and Applications   -->\n<!--                                               -->\n<!-- Copyright (C) 1997-2014  Thomas W. Judson     -->\n<!-- See the file COPYING for copying conditions.  -->\n\n<!-- This file is part of the book                 -->\n<!--                                               -->\n<!--   Abstract Algebra: Theory and Applications   -->\n<!--                                               -->\n<!-- Copyright (C) 2010-2014  Robert A. Beezer     -->\n<!-- See the file COPYING for copying conditions.  -->\n\n/g

# Kill remainder of TeX license header
/^%%%%(c)/d

# Remaining comments
# No \% as percent sign seem to be present
# Empty comments to blank lines
#
s/^%$//g
s/%\(.*\)$/<!-- \1 -->/g

# \textit for titles
# (**)  Bibliography only, for cut/paste
s/\\textit{\([^}]*\)}/<title>\1<\/title>/g

# Paragraphs
# Only in Sage exercises (?)
# Mostly an annoyance to do <\p><p>
#
s/\\par//g

####
#
# Lists
#
####
#
# After items get fixed in references
#
s/\\begin{enumerate}\nFIXME-BALANCE-LIST-ITEMS/<ol>/g
s/\\end{enumerate}\nFIXME-BALANCE-LIST-ITEMS/<\/ol>/g
s/\\begin{itemize}/<ul>/g
s/\\end{itemize}/<\/ul>/g
s/\\item/<\/li><li>/g





####
#
# Sections
#
####
# (**) all will need closing tags, ez w/ matching
# (**) Introductions need new markup
#
# Chapter
# eg, \chap{Cyclic Groups}{cyclic}
# End tag automatically from \sagesection replacement
s/\\chap{\([^}]*\)}{\([^}]*\)}/\n<chapter xml:id="\2" xmlns:xi="http:\/\/www.w3.org\/2001\/XInclude">\n<title>\1<\/title>\n\n<introduction>\n<p>FIXME: Move content in here<\/p>\n<\/introduction>/g

# Section
# eg, \section{Cyclic Subgroups}
s/\\section{\([^}]*\)}/\n<\/section>\n<section xml:id="">\n<title>\1<\/title>/g

# Suggested Reading
# eg, \subsection*{References and Suggested Readings}
s/\\subsection\*{References and Suggested Readings}/<references>\n<title>References and Suggested Readings<\/title>\nFIXME: move references in here, reorder one wrapping biblio\nFIXME: move editing comments upward\n<\/references>/g

# Subsection (unnumbered)
# eg, \subsection*{Subgroups of Cyclic Groups}
s/\\subsection\*{\([^}]*\)}/\n<\/subsection>\n<subsection number="no">\n<title>\1<\/title>/g

# Sage Subsection
# eg, \sagesubsection{Cosets}
s/\\sagesubsection{\([^}]*\)}/\n<\/subsection>\n<subsection>\n<title>\1<\/title>/g


####
#
# Index entries
#
####

# Ignore two-part entries at first, then split these out
s/\\index{\([^}]*\)}/<index><main>\1<\/main><\/index>/g
s/<index><main>\([^!]*\)!\([^<]*\)<\/main><\/index>/<index><main>\1<\/main><sub>\2<\/sub><\/index>/g


####
#
# Junk
#
####

# Kill \medskip and handle otherwise
s/\\medskip//g

# Integrate Sage sections into each chapter
# Also absorb exercises stored in another directory
# (**) There will be a chapter or two without Sage exercises
s/\\sagesection/<xi:include href=".\/exercises\/FIXME:SECTIONHERE.xml" \/>\n<xi:include href=".\/sage\/FIXME:SECTIONHERE-sage.xml" \/>\n<xi:include href=".\/sage\/FIXME:SECTIONHERE-sage-exercises.xml" \/>\n\n<\/chapter>/g

# Kill purposeful horizontal space
# Should do this with styling
# \mbox{\hspace*{1in}}
# \hspace*{1in}
# w, w/o *; w, w/o mbox
# (**) will break one or two displays
s/\\mbox{\\hspace{\([^}]*\)}}//g
s/\\mbox{\\hspace\*{\([^}]*\)}}//g
s/\\hspace{\([^}]*\)}//g
s/\\hspace\*{\([^}]*\)}//g

# (**) Maybe some \mbox{}'s in lieu of \text{}?

# Kill centering
# Should do this with styling
# (**) 49 figures, 16 tables, 31 arrays may use center environment routinely
# 100 total, 13 center's are in GFDL for sure
# Did not determine all uses; grep -A 2  "\\\\begin{figure}" *.tex
s/\\begin{center}//g
s/\\end{center}//g

####
#
# Wrap-Up
#
####

# All existing ampersands now need escaping
s/\&/&amp;/g

# Restore protections
# TeX math in tikz diagrams
/begin{tikzpicture/,/end{tikzpicture/ { s/XXXTIKZDOLLARXXX/\$/g}
/begin{tikzpicture/,/end{tikzpicture/ { s/XXXTIKZDASHXXX/--/g}
# Ampersands in matrices
/begin{pmatrix/,/end{pmatrix/   { s/XXXMATRIXAMPXXX/\&/g }
