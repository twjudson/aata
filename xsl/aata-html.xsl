<?xml version='1.0'?>

<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Abstract Algebra: Theory and Applications   -->
<!--                                               -->
<!-- Copyright (C) 1997-2014  Thomas W. Judson     -->
<!-- See the file COPYING for copying conditions.  -->

<!-- AATA customizations for HTML runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in mathbook/user, so it must be copied there -->
<xsl:import href="../xsl/pretext-html.xsl" />

<!-- Each Chapter has a <paragraphs> about Sage, -->
<!-- which will be included by default           -->
<!-- The HTML version contains the two           -->
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

<!-- Changes to mimic in HTML via CSS/other changes? -->
<!-- LaTeX: Bold and italic for terminology macro -->
<!-- LaTeX: Proof to small caps -->
<!-- LaTeX: Historical Notes -->

</xsl:stylesheet>
