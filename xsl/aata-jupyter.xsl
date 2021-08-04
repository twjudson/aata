<?xml version='1.0'?>

<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Abstract Algebra: Theory and Applications   -->
<!--                                               -->
<!-- Copyright (C) 1997-2014  Thomas W. Judson     -->
<!-- See the file COPYING for copying conditions.  -->

<!-- AATA customizations for Jupyter runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in mathbook/user, so it must be copied there -->
<xsl:import href="../xsl/pretext-jupyter.xsl" />

<!-- List Chapters and Sections in any eventual Table of Contents -->
<xsl:param name="toc.level" select="'2'" />

<!-- Exercises have "hint" and "solution"s -->
<!--   Hints: for a backmatter section     -->
<!--   Solutions: should not see them in   -->
<!--              any public print version -->
<!-- HTML: knowlize as available/appropriate -->
<!-- 
<xsl:param name="exercise.text.statement" select="'yes'" />
<xsl:param name="exercise.text.hint" select="'no'" />
-->

<!-- Each Chapter has a <paragraphs> about Sage, -->
<!-- which will be included by default           -->
<!-- The Jupyter version contains the two        -->
<!-- Sage sections (discussions and exercises)   -->
<!-- so we kill the duplicative remarks here     -->
<!-- Note: since "paragraphs" are unnumbered,    -->
<!-- their presence in the XML source has no     -->
<!-- effect on numbering, whether included or    -->
<!-- not. The situation is a bit more delicate   -->
<!-- on the LaTeX side.                          -->
<!-- These could be unnumbered "remark" once     -->
<!-- that is implemented.                        -->
<xsl:template match="paragraphs[title='Sage']" />

<!-- Changes to mimic in Jupyter via martkdown? -->
<!-- LaTeX: Bold and italic for terminology macro -->
<!-- LaTeX: Proof to small caps -->
<!-- LaTeX: Historical Notes -->

</xsl:stylesheet>
