<?xml version="1.0" encoding="UTF-8"?>
<!-- Identify as a stylesheet -->
<!-- from mathbook-common.xsl -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace" 
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:exsl="http://exslt.org/common"
    xmlns:str="http://exslt.org/strings"
    extension-element-prefixes="exsl date str"
    xmlns:mb="http://mathbook.pugetsound.edu/"

    xmlns:xi="http://www.w3.org/2001/XInclude"

    exclude-result-prefixes="mb"
>

<!-- Import "sanitize-text" routine to shift tikz code left -->
<xsl:import href="/home/rob/mathbook/mathbook/xsl/mathbook-common.xsl" />

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

<!-- One-off  XML -> XML  conversion                          -->
<!--                                                          -->
<!-- (1) all tabs to spaces                                   -->
<!--                                                          -->
<!-- (2) effect xi:includes for each chapter                  -->
<!--                                                          -->
<!-- (3) latex-image-code (ie tikz) to latex-image/xi:include -->
<!--                                                          -->
<!-- (4) solutions, or not                                    -->

<!-- From root, go -->
<xsl:template match="/">
    <xsl:apply-templates />
</xsl:template>

<!-- Expand tabs, in all text nodes         -->
<!-- Except latex-image may be caught first -->
<xsl:template match="text()">
    <xsl:value-of select="str:replace(., '&#x9;', '    ')"/>
</xsl:template>

<!-- Write out tikz code as pure text in a file -->
<!-- Leave behind (updated) include of the file -->
<xsl:template match="latex-image-code">
    <xsl:variable name="filebase">
        <xsl:value-of select="../@xml:id" />
    </xsl:variable>
    <exsl:document href="tikz/{$filebase}.tex" method="text">
        <xsl:call-template name="sanitize-text">
            <xsl:with-param name="text" select="." />
        </xsl:call-template>
    </exsl:document>
    <latex-image><xi:include href="tikz/{$filebase}.tex" parse="text"/></latex-image>
</xsl:template>

<!-- We can make versions with, and without, solutions -->
<!-- <xsl:template match="solution" /> -->

<!-- When we unwind the xinclude mechanism, a   -->
<!-- generated @xml:base appears, so we kill it -->
<xsl:template match="@xml:base" />

<!-- Identity template, if no override, then just replicates *everything* -->
<!-- #1, Mike McKay at http://www.dpawson.co.uk/xsl/sect2/identity.html   -->
<xsl:template match="node()|@*">
   <xsl:copy>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
   </xsl:copy>
</xsl:template>

</xsl:stylesheet>