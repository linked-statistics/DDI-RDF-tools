<?xml version="1.0" encoding="UTF-8"?>
<!--
Document : ddi3-1-to-rdf.xsl Description: converts a DDI 3.1 intance to RDF
DDI Ontology draft: https://raw.github.com/FranckCo/DDIOnto/master/discology.ttl

to validate output:
http://www.w3.org/RDF/Validator/

params:
studyURI the prefix for the elements uri:s eg: http://i.am.a.url.com/study/123

developed by:
Bosch, Thomas <Thomas.Bosch at gesis.org>
Olsson, Olof <olof.olsson at snd.gu.se>
Zapilko, Benjamin <Benjamin.Zapilko at gesis.org>
-->
<xsl:stylesheet version="2.0" 
                xmlns:xsl       = "http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf       = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:si        = "http://www.w3schools.com/rdf/" 
                xmlns:owl       = "http://www.w3.org/2002/07/owl#" 
                xmlns:skosclass = "http://ddialliance.org/ontologies/skosclass"
                xmlns:xml       = "http://www.w3.org/XML/1998/namespace" 
                xmlns:rdfs      = "http://www.w3.org/2000/01/rdf-schema#"
                xmlns:xsi       = "http://www.w3.org/2001/XMLSchema-instance"
                xmlns:skos      = "http://www.w3.org/2004/02/skos/core#" 
                xmlns:dc        = "http://purl.org/dc/elements/1.1/"
                xmlns:dcterms   = "http://purl.org/dc/terms/" 
                xmlns:disco     = "http://rdf-vocabulary.ddialliance.org/discovery#"
                xmlns:ddi       = "http://ddialliance.org/data/" 
                xmlns:ddilc     = "ddi:instance:3_1"
                xmlns:g         = "ddi:group:3_1"
                xmlns:d         = "ddi:datacollection:3_1"
                xmlns:dce       = "ddi:dcelements:3_1"
                xmlns:c         = "ddi:conceptualcomponent:3_1"
                xmlns:xhtml     = "http://www.w3.org/1999/xhtml"
                xmlns:a         = "ddi:archive:3_1"
                xmlns:m1        = "ddi:physicaldataproduct/ncube/normal:3_1"
                xmlns:m2        = "ddi:physicaldataproduct/ncube/tabular:3_1"
                xmlns:o         = "ddi:organizations:3_1"
                xmlns:l         = "ddi:logicalproduct:3_1"
                xmlns:m3        = "ddi:physicaldataproduct/ncube/inline:3_1"
                xmlns:pd        = "ddi:physicaldataproduct:3_1"
                xmlns:cm        = "ddi:comparative:3_1"
                xmlns:s         = "ddi:studyunit:3_1"
                xmlns:r         = "ddi:reusable:3_1"
                xmlns:pi        = "ddi:physicalinstance:3_1"
                xmlns:ds        = "ddi:dataset:3_1"
                xmlns:pr        = "ddi:profile:3_1">
    
    <xsl:import href="ddi3-1-util.xsl"/>
    <xsl:import href="ddi3-1_datacollection.xsl"/>
    <xsl:import href="ddi3-1_logicalproduct.xsl"/>
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <!-- used as a prefix for elements -->
    <xsl:param name="studyURI">http://some.uri.to.my.data.defined.as.a.param/<xsl:value-of select="/ddilc:DDIInstance/s:StudyUnit/@id"/></xsl:param>
    
    <!-- uri build params to include agency and version and prefix with element name -->   
    <xsl:param name="uri-deliminter">:</xsl:param>
    <xsl:param name="uri-prefix-elementname">true</xsl:param>
    <xsl:param name="uri-use-agency">true</xsl:param>
    <xsl:param name="uri-use-version">true</xsl:param>
    
    <!-- this param is set to true if data is publicaly accessible -->
    <xsl:param name="isPublic">false</xsl:param>
    
    <xsl:template match="/ddilc:DDIInstance">
        <rdf:RDF>
            <!-- call the templates for all the elements -->
            
            <!-- Study -->
            <xsl:apply-templates select="s:StudyUnit" />

            <!-- Universe -->
            <xsl:apply-templates select="//c:Universe" />
                    
            <!-- Concept -->
            <xsl:apply-templates select="//c:Concept" />
            
            <!-- DataFile -->


            <!-- DescriptiveStatistics -->
            

            <!-- Variables -->
            <xsl:apply-templates select="//l:Variable" />
        
            <!-- Intrument -->
            
	
            <!--Question -->
            <xsl:apply-templates select="//d:QuestionItem|//d:MultipleQuestionItem" />
        
            <!-- Categories -->
            <xsl:apply-templates select="//l:CategoryScheme" />
            <xsl:apply-templates select="//l:CodeScheme" />
        
            <!-- Coverage -->
            
	
            <!-- Location -->	
            
            
            <!-- LogicalDataSet -->
         
        </rdf:RDF>
    </xsl:template>
    
    <!-- Study -->
    <xsl:template match="s:StudyUnit">
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$studyURI" />
            </xsl:attribute>
            
            <rdf:type>
                <xsl:attribute name="rdf:resource"><xsl:value-of select="$discoURI" />Study</xsl:attribute>
            </rdf:type>
            
            <xsl:apply-templates select="r:Citation" />
            
            <!-- identifier -->
            <dc:identifier>
                <xsl:value-of select="@id"/>
            </dc:identifier>
                        
            <!-- AnalysisUnit -->
            <xsl:if test="r:AnalysisUnit">
                <disco:AnalysisUnit>
                    <rdf:Description>
                        <rdf:type>
                            <xsl:attribute name="rdf:resource">http://www.w3.org/2004/02/skos/core#Concept</xsl:attribute>
                        </rdf:type>
                        
                        <skos:prefLabel>
                            <xsl:call-template name="createLanguageAttribute"/>
                            <xsl:value-of select="r:AnalysisUnit" />
                        </skos:prefLabel>
                    </rdf:Description>
                </disco:AnalysisUnit>
            </xsl:if>
            
            <!-- abstract -->
            <xsl:for-each select="s:Abstract">
                <dcterms:abstract>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="r:Content/@xml:lang" />
                    </xsl:attribute>
                    <xsl:value-of select="r:Content"/>
                </dcterms:abstract>
            </xsl:for-each>

            <!-- purpose -->
            <xsl:for-each select="s:Purpose">
                <disco:purpose>
                    
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="r:Content/@xml:lang" />
                    </xsl:attribute>
                    <xsl:value-of select="r:Content"/>
                </disco:purpose>
            </xsl:for-each>            
                                    
            <!-- disco:isMeasureOf -->
            <xsl:for-each select="r:UniverseReference">
                <disco:isMeasureOf>
                    <xsl:attribute name="rdf:resource">
                        <xsl:call-template name="createUriByReference"/>
                    </xsl:attribute>                    
                </disco:isMeasureOf>
            </xsl:for-each>
            
            <!-- disco:HasInstrument -->
            <xsl:if test="//d:QuestionItem|//d:MultipleQuestionItem">
                <disco:questionaire>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$studyURI" /><xsl:text>#questionnaire</xsl:text>
                    </xsl:attribute>   
                </disco:questionaire>
            </xsl:if>
            
            <!-- dc:hasPart -->
            <!-- disco:HasDataFile -->
            
            <!-- disco:variable -->
            <xsl:for-each select="//l:Variable">
                <disco:variable>
                    <xsl:call-template name="createUriByElement"/>
                </disco:variable>
            </xsl:for-each>
            
            <!-- disco:HasCoverage -->
            
        </rdf:Description>
        
        <xsl:if test="//d:QuestionItem|//d:MultipleQuestionItem">
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="$studyURI" /><xsl:text>#questionnaire</xsl:text>
                </xsl:attribute> 
                <rdf:type>
                    <xsl:attribute name="rdf:resource"><xsl:value-of select="$discoURI" />Questionnaire</xsl:attribute>
                </rdf:type>
                
                <xsl:for-each select="//d:ModeOfCollection">
                    <disco:CollectionMode>
                        <xsl:attribute name="rdf:resource">
                            <xsl:call-template name="createUriByReference"/>
                        </xsl:attribute>
                    </disco:CollectionMode>
                </xsl:for-each>
                <disco:concept>
                    <xsl:attribute name="skos:Concept">
                        <xsl:call-template name="createUriByReference"/>
                    </xsl:attribute>
                </disco:concept>
                
                <xsl:for-each select="//d:QuestionItem|//d:MultipleQuestionItem">
                    <disco:question>
                        <xsl:attribute name="rdf:resource">
                            <xsl:call-template name="createUriByElement"/>
                        </xsl:attribute>  
                    </disco:question>
                </xsl:for-each>
            </rdf:Description>
        </xsl:if>
    </xsl:template>

    <xsl:template match="r:Citation">
        <xsl:for-each select="r:Title">
            <dcterms:title>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
                <xsl:value-of select="." />
            </dcterms:title>
        </xsl:for-each>
        <xsl:for-each select="r:AlternativeTitle">
            <dcterms:alternative>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
                <xsl:value-of select="." />
            </dcterms:alternative>
        </xsl:for-each>        
        <xsl:for-each select="r:SubTitle">
            <disco:subtitle>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
                <xsl:value-of select="." />
            </disco:subtitle>
        </xsl:for-each>        
    </xsl:template>
        
    <!-- Universe -->
    <xsl:template match="c:Universe">
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$studyURI" />
                <xsl:text>#universe-</xsl:text>
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <rdf:type>
                <xsl:attribute name="rdf:resource"><xsl:value-of select="$discoURI" />Universe</xsl:attribute>
            </rdf:type>            
            <xsl:for-each select="c:HumanReadable">
                <skos:definition>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="@xml:lang"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </skos:definition>
            </xsl:for-each>
        </rdf:Description>
    </xsl:template>
    
    <!-- Concept -->
    <xsl:template match="c:Concept">        
        <rdf:Description>
            <xsl:call-template name="createUriByElement"/>
            <rdf:type>
                <xsl:attribute name="rdf:resource"><xsl:text>http://www.w3.org/2004/02/skos/core#Concept</xsl:text></xsl:attribute>
            </rdf:type>            
            <xsl:for-each select="r:Label">
                    <xsl:call-template name="createSkosLabel"/>                
            </xsl:for-each>
        </rdf:Description>
    </xsl:template>
    
    <!-- Coverage -->
    <xsl:template match="r:Coverage">
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$studyURI" />
                <xsl:text>#coverage-</xsl:text>
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <rdf:type>
                <xsl:attribute name="rdf:resource"><xsl:value-of select="$discoURI" />Coverage</xsl:attribute>
            </rdf:type>
        </rdf:Description>
    </xsl:template>
</xsl:stylesheet>