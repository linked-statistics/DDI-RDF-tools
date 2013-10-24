<?xml version="1.0" encoding="UTF-8"?>
<!--
Document : ddi3-1-util.xsl Description: utillities for convertions of DDI 3.1 intance to RDF
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:si="http://www.w3schools.com/rdf/"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:skosclass="http://ddialliance.org/ontologies/skosclass"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:disco="http://rdf-vocabulary.ddialliance.org/discovery#"
    xmlns:ddi="http://ddialliance.org/data/" xmlns:ddilc="ddi:instance:3_1" xmlns:g="ddi:group:3_1"
    xmlns:d="ddi:datacollection:3_1" xmlns:dce="ddi:dcelements:3_1"
    xmlns:c="ddi:conceptualcomponent:3_1" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:a="ddi:archive:3_1" xmlns:m1="ddi:physicaldataproduct/ncube/normal:3_1"
    xmlns:m2="ddi:physicaldataproduct/ncube/tabular:3_1" xmlns:o="ddi:organizations:3_1"
    xmlns:l="ddi:logicalproduct:3_1" xmlns:m3="ddi:physicaldataproduct/ncube/inline:3_1"
    xmlns:pd="ddi:physicaldataproduct:3_1" xmlns:cm="ddi:comparative:3_1"
    xmlns:s="ddi:studyunit:3_1" xmlns:r="ddi:reusable:3_1" xmlns:pi="ddi:physicalinstance:3_1"
    xmlns:ds="ddi:dataset:3_1" xmlns:pr="ddi:profile:3_1">

    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:param name="studyURI">http://www.example.com/</xsl:param>

    <xsl:param name="uri-deliminter">:</xsl:param>
    <xsl:param name="uri-prefix-elementname">true</xsl:param>
    <xsl:param name="uri-use-agency">true</xsl:param>
    <xsl:param name="uri-use-version">true</xsl:param>

    <xsl:template name="createUriByElement">
        <xsl:value-of select="$studyURI"/>
        <xsl:text>#</xsl:text>

        <xsl:if test="$uri-prefix-elementname='true'">
            <xsl:value-of select="lower-case(local-name())"/>
            <xsl:text>-</xsl:text>
        </xsl:if>

        <xsl:if test="@agency and $uri-use-agency='true'">
            <xsl:value-of select="@agency"/>
            <xsl:value-of select="$uri-deliminter"/>
        </xsl:if>

        <xsl:value-of select="@id"/>

        <xsl:if test="@version and $uri-use-version='true'">
            <xsl:value-of select="$uri-deliminter"/>
            <xsl:value-of select="@version"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="createUriByReference">
        <xsl:value-of select="$studyURI"/>
        <xsl:text>#</xsl:text>
        
        <xsl:if test="$uri-prefix-elementname='true'">
            <xsl:value-of select="lower-case(substring-before(local-name(), 'Reference'))"/>
            <xsl:text>-</xsl:text>
        </xsl:if>
        
        <xsl:if test="r:IdentifyingAgency and $uri-use-agency='true'">
            <xsl:value-of select="./r:IdentifyingAgency/text()"/>
            <xsl:value-of select="$uri-deliminter"/>
        </xsl:if>

        <xsl:value-of select="r:ID/text()"/>

        <xsl:if test="r:Version and $uri-use-version='true'">
            <xsl:value-of select="$uri-deliminter"/>
            <xsl:value-of select="r:Version/text()"/>
        </xsl:if>
    </xsl:template>
        
    <xsl:template name="createLanguageAttribute">
        <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang" select="@xml:lang" />
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
