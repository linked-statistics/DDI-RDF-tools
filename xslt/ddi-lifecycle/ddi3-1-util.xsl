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

    <xsl:variable name="base-xmlschema-url">
        <xsl:text>http://www.w3.org/TR/2001/REC-xmlschema-2-20010502/#</xsl:text>
    </xsl:variable>

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
            <xsl:attribute name="xml:lang" select="@xml:lang"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="createSkosLabel">
        <xsl:choose>
            <xsl:when test="@translated='false'">
                <skos:prefLabel>
                    <xsl:call-template name="createLanguageAttribute"/>
                    <xsl:value-of select="."/>
                </skos:prefLabel>
            </xsl:when>
            <xsl:when test="@translated='true'">
                <skos:altLabel>
                    <xsl:call-template name="createLanguageAttribute"/>
                    <xsl:value-of select="."/>
                </skos:altLabel>
            </xsl:when>
            <xsl:otherwise>
                <skos:prefLabel>
                    <xsl:call-template name="createLanguageAttribute"/>
                    <xsl:value-of select="."/>
                </skos:prefLabel>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="createRdfsTypeRepresentation">
        <xsl:param name="type"/>
        <disco:representation>
            <xsl:attribute name="rdfs:Datatype">
                <xsl:value-of select="$base-xmlschema-url"/>
                <xsl:value-of select="$type"/>
            </xsl:attribute>
        </disco:representation>
    </xsl:template>

    <xsl:template name="createDiscoRepresentation">
        <xsl:param name="type"/>

        <!-- String -->
        <xsl:if test="String">
            <xsl:call-template name="createRdfsTypeRepresentation">
                <xsl:with-param name="type">
                    <xsl:text>string</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>

        <!-- BigInteger  Integer  Long  Short  Decimal  Float  Double  Count  Incremental -->
        <xsl:choose>
            <!-- BigInteger -->
            <xsl:when test="$type='BigInteger'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>integer</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Integer -->
            <xsl:when test="$type='Integer'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>integer</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Long -->
            <xsl:when test="$type='Long'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>long</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Short -->
            <xsl:when test="$type='Short'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>short</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Decimal -->
            <xsl:when test="$type='Decimal'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>decimal</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Float -->
            <xsl:when test="$type='Float'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>float</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Double -->
            <xsl:when test="$type='Double'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>double</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Count -->
            <xsl:when test="$type='Count'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>integer</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Incremental -->
            <xsl:when test="$type='Incremental'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>integer</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- DateTime  Date  Time  Year  Month  Day  MonthDay  YearMonth  Duration   -->
            <!-- DateTime -->
            <xsl:when test="$type='DateTime'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>datetime</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Date -->
            <xsl:when test="$type='Date'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>date</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Time -->
            <xsl:when test="$type='Time'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>time</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Year -->
            <xsl:when test="$type='Year'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>year</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Month -->
            <xsl:when test="$type='Month'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>month</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Day -->
            <xsl:when test="$type='Day'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>day</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- MonthDay -->
            <xsl:when test="$type='MonthDay'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>monthday</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- YearMonth -->
            <xsl:when test="$type='YearMonth'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>yearmonth</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <!-- Duration -->
            <xsl:when test="$type='Duration'">
                <xsl:call-template name="createRdfsTypeRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>duration</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
