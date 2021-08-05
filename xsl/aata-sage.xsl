<?xml version='1.0'?>

<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Abstract Algebra: Theory and Applications   -->
<!--                                               -->
<!-- Copyright (C) 1997-2014  Thomas W. Judson     -->
<!-- See the file COPYING for copying conditions.  -->

<!-- For a PDF version of the book, everything electronic -->
<!-- Includes Sage material, but not remarks about Sage   -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes this file is in mathbook/user, so it must be copied there -->
<xsl:import href="aata-latex.xsl" />

<!-- Each Chapter has a <paragraphs> about Sage, -->
<!-- which will be included by default           -->
<!-- The PDF version contains the two            -->
<!-- Sage sections (discussions and exercises)   -->
<!-- so we kill the duplicative remarks here     -->
<!-- Note: since "paragraphs" are unnumbered,    -->
<!-- removing them from the LaTeX version has    -->
<!-- no effect on the numbering.                 -->
<!-- These could be unnumbered "remark" once     -->
<!-- that is implemented.                        -->
<xsl:template match="paragraphs[title='Sage']" />

</xsl:stylesheet>