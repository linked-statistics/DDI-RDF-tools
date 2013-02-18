<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl       = "http://www.w3.org/1999/XSL/Transform"
	version         = "1.0" 
	xmlns:rdf       = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:si        = "http://www.w3schools.com/rdf/" 
	xmlns:owl       = "http://www.w3.org/2002/07/owl#"
	xmlns:skosclass = "http://ddialliance.org/ontologies/skosclass"
	xmlns:xml       = "http://www.w3.org/XML/1998/namespace" 
	xmlns:rdfs      = "http://www.w3.org/2000/01/rdf-schema#"
	xmlns:skos      = "http://www.w3.org/2004/02/skos/core#" 
	xmlns:dc        = "http://purl.org/dc/elements/1.1/"
	xmlns:dcterms   = "http://purl.org/dc/terms/" 
	xmlns:disco     = "http://vocab.ddialliance.org/discovery#"
	xmlns:ddi       = "http://ddialliance.org/data/" 
	xmlns:ddicb     = "http://www.icpsr.umich.edu/DDI"
	xmlns:qb        = "http://purl.org/linked-data/cube#">
    <xsl:output method="xml" indent="yes"/>

    <!-- DataFile Template -->
    <xsl:template match="//ddicb:fileDscr/ddicb:fileTxt">
        <rdf:Description>
            <!-- URI -->
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$studyURI"/>-<xsl:value-of select="ddicb:fileName"/>
            </xsl:attribute>

            <!-- rdf:type -->
            <rdf:type>
                <xsl:attribute name="rdf:resource">http://vocab.ddialliance.org/discovery#DataFile</xsl:attribute>
            </rdf:type>

            <!-- disco:hasCoverage -->
            <disco:hasCoverage>
                <xsl:attribute name="rdf:resource">coverage-<xsl:value-of select="$studyURI"/></xsl:attribute>
            </disco:hasCoverage>

            <!-- dc:identifier -->
            <xsl:if test="ddicb:fileName!=''">
                <dc:identifier><xsl:value-of select="ddicb:fileName"/></dc:identifier>
            </xsl:if>

            <!-- dc:description -->
            <xsl:if test="ddicb:fileCont!=''">
                <dc:description><xsl:value-of select="ddicb:fileCont"/></dc:description>
            </xsl:if>

            <!-- disco:caseQuantity -->
            <xsl:for-each select="ddicb:dimensns/ddicb:caseQnty">
                <disco:caseQuantity>
                    <xsl:value-of select="."/>
                </disco:caseQuantity>
            </xsl:for-each>

            <!-- dc:format -->
            <xsl:if test="ddicb:fileType!=''">
                <dc:format>
                    <xsl:value-of select="ddicb:fileType"/>
                </dc:format>
            </xsl:if>

            <!-- dc:provenance -->
            <xsl:if test="ddicb:filePlac!=''">
                <dc:provenance>
                    <xsl:value-of select="ddicb:filePlac"/>
                </dc:provenance>
            </xsl:if>

            <!-- owl:versionInfo -->
            <xsl:for-each select="ddicb:verStmt">
                <xsl:choose>
                    <xsl:when test="ddicb:version!=''">
                        <xsl:element name="owl:versionInfo">
                            <xsl:value-of select="ddicb:version"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="owl:versionInfo">
                            <xsl:value-of select="ddicb:version/@date"/>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </rdf:Description>

    </xsl:template>


    <!-- DescriptiveStatistics Template -->
    <xsl:template match="//ddicb:dataDscr/ddicb:var/ddicb:catgry">

        <xsl:variable name="variableURI">
            <xsl:choose>
                <xsl:when test="../@name!=''">
                    <xsl:value-of select="../@name"/>
                </xsl:when>
                <xsl:when test="../@ID!=''">
                    <xsl:value-of select="../@ID"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>


        <rdf:Description>
            <!-- URI -->
            <xsl:attribute name="rdf:about">descriptiveStatistics-<xsl:value-of select="$studyURI"
                />-<xsl:value-of select="$variableURI"/>-<xsl:value-of select="ddicb:catValu"
                />
            </xsl:attribute>

            <!-- rdf:type -->
            <xsl:element name="rdf:type">
                <xsl:attribute name="rdf:resource"
                >http://vocab.ddialliance.org/discovery#DescriptiveStatistics</xsl:attribute>
            </xsl:element>

            <!-- disco:hasStatisticsValue -->
            <xsl:element name="disco:hasStatisticsValue">
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="$studyURI"/>-<xsl:value-of
                        select="$variableURI"/>
                </xsl:attribute>
            </xsl:element>

            <!-- disco:hasStatisticsCategory -->
            <xsl:for-each select="ddicb:labl">
                <xsl:element name="disco:hasStatisticsCategory">
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="../ddicb:catValu"
                        />-<xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>

            <!-- disco:hasStatisticsDataFile -->
            <xsl:for-each select="//ddicb:codeBook/ddicb:fileDscr/ddicb:fileTxt">
                <xsl:element name="disco:hasStatisticsDataFile">
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$studyURI"
                        />-<xsl:value-of select="ddicb:fileName"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>

            <!-- disco:frequency -->
            <!--<xsl:for-each select="ddicb:catStat[@type='freq'!='']">-->
            <!-- Thomas, 24.04.2012: -->
            <xsl:for-each select="ddicb:catStat[@type='freq']">
                <!-- Thomas, 24.04.2012: -->
                <xsl:if test=". != ''">
                    <xsl:element name="disco:frequency">
                        <xsl:value-of select="."/>
                    </xsl:element>
                    <!-- Thomas, 24.04.2012: -->
                </xsl:if>
            </xsl:for-each>

            <!-- disco:percentage -->
            <!--<xsl:for-each select="ddicb:catStat[@type='percent'!='']">-->
            <!-- Thomas, 24.04.2012: -->
            <xsl:for-each select="ddicb:catStat[@type='percent']">
                <!-- Thomas, 24.04.2012: -->
                <xsl:if test=". != ''">
                    <xsl:element name="disco:percentage">
                        <xsl:value-of select="."/>
                    </xsl:element>
                    <!-- Thomas, 24.04.2012: -->
                </xsl:if>
            </xsl:for-each>

            <!-- disco:weightedFrequency -->
            <!--<xsl:for-each select="ddicb:catStat[@type='freq'!='']">-->
            <!--<xsl:for-each select="ddicb:catStat[@type='freq'] !=''">-->
            <!-- Thomas, 24.04.2012: -->
            <xsl:for-each select="ddicb:catStat[@type='freq']">
                <!-- Thomas, 24.04.2012: -->
                <xsl:if test=". != ''">
                    <!-- Thomas, 24.04.2012: -->
                    <xsl:choose>
                        <xsl:when test="@wgt-var != ''">
                            <!--<xsl:if test="@wgt-var != ''">-->
                            <xsl:element name="disco:weightedFrequency">
                                <xsl:value-of select="."/>-<xsl:value-of select="@wgt-var"/>
                            </xsl:element>
                            <!--</xsl:if>-->
                        </xsl:when>
                        <xsl:when test="@weight!=''">
                            <xsl:element name="disco:weightedFrequency">
                                <xsl:value-of select="."/>-<xsl:value-of select="@weight"/>
                            </xsl:element>
                        </xsl:when>
                    </xsl:choose>
                    <!-- Thomas, 24.04.2012: -->
                </xsl:if>
                <!--<xsl:if test="@weight!=''">
                    <xsl:element name="disco:weightedFrequency">
                        <xsl:value-of select="."/>-<xsl:value-of select="@weight"/>
                    </xsl:element>
                </xsl:if>-->
            </xsl:for-each>

            <!-- disco:weightedBy -->
            <xsl:for-each select="ddicb:catStat[@type='freq']">
                <!-- Thomas, 24.04.2012: -->
                <xsl:choose>
                    <xsl:when test="../../@name">
                        <xsl:choose>
                            <xsl:when test="@wgt-var!=''">
                                <xsl:element name="disco:weightedBy">
                                    <xsl:value-of select="$studyURI"/>-<xsl:value-of select="../../@name"/>-<xsl:value-of select="@wgt-var"/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="@weight!=''">
                                <xsl:element name="disco:weightedBy">
                                    <xsl:value-of select="$studyURI"/>-<xsl:value-of select="../../@name"/>-<xsl:value-of select="@weight"/>
                                </xsl:element>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="../../@ID">
                        <xsl:choose>
                            <xsl:when test="@wgt-var!=''">
                                <xsl:element name="disco:weightedBy">
                                    <xsl:value-of select="$studyURI"/>-<xsl:value-of select="../../@ID"/>-<xsl:value-of select="@wgt-var"/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="@weight!=''">
                                <xsl:element name="disco:weightedBy">
                                    <xsl:value-of select="$studyURI"/>-<xsl:value-of select="../../@ID"/>-<xsl:value-of select="@weight"/>
                                </xsl:element>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
                <!--<xsl:if test="@wgt-var!=''">
            <xsl:element name="disco:weightedBy">
                --><!-- Caution: Variable does not always have an ID, should be used name instead? --><!--
                        <xsl:value-of select="$studyURI"/>-<xsl:value-of select="../../@ID"
                            />-<xsl:value-of select="@wgt-var"/>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="@weight!=''">
                    <xsl:element name="disco:weightedBy">
                        <xsl:value-of select="$studyURI"/>-<xsl:value-of select="../../@ID"
                            />-<xsl:value-of select="@weight"/>
                    </xsl:element>
                </xsl:if>-->
            </xsl:for-each>
        </rdf:Description>
    </xsl:template>

    <!-- Variable Template -->
    <xsl:template match="//ddicb:dataDscr/ddicb:var">
        
        <xsl:variable name="variableBaseURI">
            <xsl:choose>
                <xsl:when test="@name!=''">
                    <xsl:value-of select="@name"/>
                </xsl:when>
                <xsl:when test="@ID!=''">
                    <xsl:value-of select="@ID"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        
        <rdf:Description>
            <!-- URI -->
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$studyURI"/>-<xsl:value-of select="$variableBaseURI"/>
            </xsl:attribute>
            
            <!-- rdf:type -->
            <xsl:element name="rdf:type">
                <xsl:attribute name="rdf:resource">http://vocab.ddialliance.org/discovery#Variable</xsl:attribute>
            </xsl:element>

            <!-- disco:hasConcept -->
            <xsl:for-each select="ddicb:catgry/ddicb:labl">
                <xsl:element name="disco:hasConcept">
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="../ddicb:catValu"/>-<xsl:value-of select="."/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>
            
            <!-- disco:holdsMeasurementOf -->
            <xsl:for-each select="ddicb:universe">
                <xsl:choose>
                    <xsl:when test="@ID!=''">                        
                        <xsl:element name="disco:holdsMeasurementOf">
                            <xsl:attribute name="rdf:resource">universe-<xsl:value-of select="@ID"/></xsl:attribute>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="disco:holdsMeasurementOf">
                            <xsl:attribute name="rdf:resource">universe-<xsl:value-of select="."/></xsl:attribute>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <!-- disco:hasRepresentation -->
            <xsl:choose>
                <xsl:when test="@name!=''">                        
                    <xsl:element name="disco:hasRepresentation">
                        <xsl:attribute name="rdf:resource">representation-<xsl:value-of select="$studyURI"/>-<xsl:value-of select="@name"/></xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="disco:hasRepresentation">
                        <xsl:attribute name="rdf:resource">representation-<xsl:value-of select="$studyURI"/>-<xsl:value-of select="@ID"/></xsl:attribute>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>

            <!-- disco:isPopulatedBy -->
            <xsl:element name="disco:isPopulatedBy">
                <xsl:attribute name="rdf:resource">instrument-<xsl:value-of select="$studyURI"/></xsl:attribute>
            </xsl:element>

            <!-- disco:hasQuestion -->
            <xsl:for-each select="ddicb:qstn">
                <xsl:choose>
                    <xsl:when test="@ID!=''">                        
                        <xsl:element name="disco:hasQuestion">
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of select="@ID"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="../@ID!=''">                        
                        <xsl:element name="disco:hasQuestion">
                            <xsl:attribute name="rdf:resource">question-<xsl:value-of select="../@ID"/></xsl:attribute>
                        </xsl:element>
                    </xsl:when>                    
                    <xsl:otherwise>
                        <xsl:element name="disco:hasQuestion">
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of select="ddicb:qstnLit"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>

            <!-- disco:usesDataElement -->
            <!-- no DataElement in DDI2.1 -->

            <!-- dc:identifier -->
            <xsl:choose>
                <xsl:when test="@name!=''">
                    <xsl:element name="dc:identifier">
                        <xsl:value-of select="$studyURI"/>-<xsl:value-of select="@name"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="dc:identifier">
                        <xsl:value-of select="$studyURI"/>-<xsl:value-of select="@ID"/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>

            <!-- skos:prefLabel -->
            <xsl:if test="ddicb:labl!=''">
                <xsl:element name="skos:prefLabel">
                    <xsl:value-of select="ddicb:labl"/>
                </xsl:element>
            </xsl:if>
            
            <!-- dc:description -->
            <xsl:if test="ddicb:txt!=''">
                <xsl:element name="dc:description">
                    <xsl:value-of select="ddicb:txt"/>
                </xsl:element>
            </xsl:if>

        </rdf:Description>
    </xsl:template>

    <!-- DataFile Template -->
    <!-- no DataElement in DDI2.1 -->
</xsl:stylesheet>
