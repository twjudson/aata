<?xml version='1.0'?>

<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Abstract Algebra: Theory and Applications   -->
<!--                                               -->
<!-- Copyright (C) 1997-2014  Thomas W. Judson     -->
<!-- See the file COPYING for copying conditions.  -->

<!-- For the print version of the book, nothing electronic    -->
<!-- Includes Sage remarks, but none of the other Sage extras -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes this file is in mathbook/user, so it must be copied there -->
<xsl:import href="aata-latex.xsl" />

<!-- Assumes next file can be found in mathbook/user, so it must be copied there -->
<xsl:import href="aata-common.xsl" />

<xsl:param name="latex.font.size" select="'11pt'" />

<!-- Print edition is 4 3/8 inches wide for body, using 4 1/2 inch now -->
<!-- Default is "letterpaper", we could fine-tune margins if desired   -->
<xsl:param name="latex.geometry">
	<xsl:text>textwidth=4.375in,textheight=9in</xsl:text>
</xsl:param>

<!-- Makes hyperlinks, program listings, etc. black & white -->
<xsl:param name="latex.print" select="'yes'" />

<!-- Each Chapter has a <remark> about Sage,         -->
<!-- which will be included by default               -->
<!-- But print copies of AATA will not include       -->
<!-- the two Sage sections (discussion and exercise) -->
<!-- This is where we kill these two sections        -->
<xsl:template match="section[title='Sage']" />
<xsl:template match="exercises[title='Sage Exercises']" />

</xsl:stylesheet>