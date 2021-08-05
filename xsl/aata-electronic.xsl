<?xml version='1.0'?>

<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Abstract Algebra: Theory and Applications   -->
<!--                                               -->
<!-- Copyright (C) 1997-2014  Thomas W. Judson     -->
<!-- See the file COPYING for copying conditions.  -->

<!-- This is similar to the print version of the book, nothing electronic -->
<!-- but everything is electronic: active hyperlinks, colored text        -->
<!-- Includes Sage remarks, but none of the other Sage extras             -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Copy current file (aata-print.xsl) into mathbook/user -->
<!-- Then other imports are all relative to that directory -->

<!-- Copy  aata-latex.xsl  into  mathbook/user                 -->
<!-- aata-latex.xsl  will subsequently import  aata-common.xsl -->
<xsl:import href="aata-latex.xsl" />

<!-- Each Chapter has a <paragraphs> about Sage,      -->
<!-- which will be included by default                -->
<!-- But print copies of AATA will not include        -->
<!-- the two Sage sections (discussion and exercise)  -->
<!-- This is where we kill these two sections         -->
<xsl:template match="section[title='Sage']" />
<xsl:template match="exercises[title='Sage Exercises']" />

</xsl:stylesheet>