#! /bin/bash

declare -x XMLLINT_INDENT="    "

SRC=/home/rob/books/aata/aata/src
SLN=/home/rob/books/aata_solutions_project/src
SCRIPT=/home/rob/books/aata/aata/script
IN=/tmp/conin
OUT=/tmp/conout

# install -d ${IN}/exercises 
install -d ${OUT}/tikz

# cp -a ${SRC}/* ${IN}
# cp -a ${SLN}/* ${IN}/exercises
# mv ${IN}/exercises/*-sage-exercises.xml ${IN}/sage

# do not convert aata w/ -xinclude, it'll get everything
FILES=(bookinfo frontmatter backmatter gfdl-mathbook integers cosets sylow actions algcodes boolean crypt cyclic domains fields finite galois groups homomorph isomorph matrix normal permute poly rings sets struct vect)

# so stylesheet file writes are just relative
cd ${OUT}

# Careful:
# the xmllint command was seen removing a pure text mode 
# in a paragraph that lay between two "em" elements

for F in ${FILES[*]}
do
    xsltproc -xinclude ${SCRIPT}/consolidate.xsl ${IN}/${F}.xml > ${OUT}/${F}-pre.xml
    xmllint --format ${OUT}/${F}-pre.xml --output ${OUT}/${F}.xml
done

# master file, w/out xinclude
xsltproc ${SCRIPT}/consolidate.xsl ${IN}/aata.xml > ${OUT}/aata-pre.xml
xmllint --format ${OUT}/aata-pre.xml --output ${OUT}/aata.xml

# rm *-pre.xml

cd -