<?xml version='1.0'?>

<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Abstract Algebra: Theory and Applications   -->
<!--                                               -->
<!-- Copyright (C) 1997-2022  Thomas W. Judson     -->
<!-- See the file COPYING for copying conditions.  -->

<!-- AATA customizations for ALL LaTeX runs of any type -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in mathbook/user, so it must be copied there -->
<xsl:import href="../xsl/pretext-latex.xsl" />

<!-- Formatting adjustments and overrides     -->
<!-- Named templates in case we want to       -->
<!-- change up preamble easily in an override -->

<!-- Bold and italic for terminology macro -->
<!-- http://tex.stackexchange.com/questions/46690/standard-order-for-bolditalic -->
<xsl:template name="aata-terminology">
    <xsl:text>% Definitions to bold italics&#xa;</xsl:text>
    <xsl:text>\renewcommand{\terminology}[1]%&#xa;</xsl:text>
    <xsl:text>{{\fontshape{\itdefault}\fontseries{\bfdefault}\selectfont #1\/}}&#xa;</xsl:text>
</xsl:template>

<!-- Proof to small caps -->
<!-- Inherited from old PWS-Kent style                          -->
<!-- Otherwise identical to default tcb-style, so keep in sync? -->
<xsl:template match="proof" mode="tcb-style">
    <xsl:text>bwminimalstyle, fonttitle=\normalfont\scshape, attach title to upper, after title={\space}, after upper={\space\space\hspace*{\stretch{1}}\(\blacksquare\)},&#xa;</xsl:text>
</xsl:template>

<!-- tcolorbox environment for AATA "Historical Notes"    -->
<!-- Similar to PWS-Kent style, with no closing rectangle -->
<!-- Presumes that tcolorbox is full loaded anyway        -->
<!-- Eventually this will be an "aside-like"              -->
 <xsl:template name="aata-historical-environment">
    <xsl:text>% Environment for Historical Notes (AATA-specific)&#xa;</xsl:text>
    <xsl:text>\tcbset{ aatahistoricalstyle/.style={size=minimal, boxrule=-0.3pt, frame empty, colback=white, colbacktitle=white, coltitle=black, fonttitle=\itshape\bfseries, before skip=3ex, bottomtitle=2ex, breakable, title={\raisebox{3pt}{\framebox[0.3\textwidth]{\relax}} \hfill {Historical Note} \hfill \raisebox{3pt}{\framebox[0.3\textwidth]{\relax}}}} }&#xa;</xsl:text>
    <xsl:text>\newtcolorbox{historicalnote}{aatahistoricalstyle}&#xa;</xsl:text>
</xsl:template>

<!-- RAB, 2010/06/17, 2014/10/14, 2018/10/20 -->
<!-- Mimics chapter headings from PWS-Kent original     -->
<!-- "bigbolditalic" is a scaled slanted 10pt font      -->
<!-- Vertical distances chosen to match, experimentally -->
<!-- \titleformat{command}[shape]{format}{label}{sep}{before-code}[after-code] -->
<xsl:template name="titlesec-chapter-style">
    <xsl:text>\titleformat{\chapter}[block]%&#xa;</xsl:text>
    <xsl:text>{\Huge\bfseries\font\bigbolditalic=cmsl10 scaled\magstep5}%&#xa;</xsl:text>
    <xsl:text>{\rule{0.4\textwidth}{.5pt}\hfill%&#xa;</xsl:text>
    <xsl:text>\raisebox{-.1in}{\fbox{\fbox{\bigbolditalic\thechapter\/}}}%&#xa;</xsl:text>
    <xsl:text>\hfill\rule{0.4\textwidth}{.5pt}}%&#xa;</xsl:text>
    <xsl:text>{0pt}{\vskip 20pt \centerline{#1}}%&#xa;</xsl:text>
    <xsl:text>[{\vskip -10pt \framebox[\textwidth]{\relax}}]%&#xa;</xsl:text>
    <!--  -->
    <xsl:text>\titleformat{name=\chapter,numberless}[block]%&#xa;</xsl:text>
    <xsl:text>{\Huge\bfseries}%&#xa;</xsl:text>
    <xsl:text>{\rule{\textwidth}{.5pt}}%&#xa;</xsl:text>
    <xsl:text>{0pt}{\vskip 20pt \centerline{#1}}%&#xa;</xsl:text>
    <xsl:text>[{\vskip -10pt \framebox[\textwidth]{\relax}}]%&#xa;</xsl:text>
    <!--  -->
    <xsl:text>\titlespacing*{\chapter}{0pt}{0pt}{40pt}&#xa;</xsl:text>
</xsl:template>

<!-- Page headers, designed to mimic PWS-Kent original -->
<!-- Slanted, uppercase, no periods (ie not LaTeX)     -->
<!-- \sethead[even-left][even-center][even-right]      -->
<!--         {odd-left}{odd-center}{odd-right}         -->
<xsl:template match="book" mode="titleps-headings">
    <xsl:text>{&#xa;</xsl:text>
    <xsl:text>\sethead[\thepage][][\ifthechapter{\MakeUppercase{\textsl{\chaptertitlename\space\thechapter\space\space\chaptertitle}}}{}]&#xa;</xsl:text>
    <xsl:text>{\ifthesection{\MakeUppercase{\textsl{\thesection\space\space\sectiontitle}}}{}}{}{\thepage}&#xa;</xsl:text>
    <xsl:text>}&#xa;</xsl:text>
</xsl:template>

<!-- Stuff them into the preamble at the end -->
<xsl:param name="latex.preamble.late">
    <xsl:call-template name="aata-terminology" />
    <xsl:call-template name="aata-historical-environment" />
</xsl:param>

<!-- We assume a common title so the template matches.       -->
<!-- These MUST be subsections and they must be the last     -->
<!-- subsection of a section, or else the numbering of other -->
<!-- subsections will be different when LaTeX auto-numbers   -->
<xsl:template match="subsection[title='Historical Note']">
    <xsl:apply-templates select="." mode="console-typeout" />
    <xsl:text>\begin{historicalnote}&#xa;</xsl:text>
    <xsl:apply-templates />
    <xsl:text>\end{historicalnote}&#xa;</xsl:text>
</xsl:template>

</xsl:stylesheet>
