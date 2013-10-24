<?xml version="1.0" encoding="UTF-8"?>
<!--
Document : ddi3-1-to-rdf.xsl Description: converts a DDI 3.1 intance to RDF
Assigned : Thomas Bosch
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
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    
    <xsl:template match="l:Variable">
        <!--
            Implementation, use "-" for marking when it´s done
            -dcterms:description		
            -dcterms:identifier		
            -skos:prefLabel		
            -skos:notation		
            -disco:question		disco:Question
            disco:representation	union of (skos:ConceptScheme rdfs:Datatype)
            disco:basedOn		disco:VariableDefinition
            disco:concept		skos:Concept
            disco:analysisUnit		disco:AnalysisUnit
            disco:universe		disco:Universe
        -->
        
         <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:call-template name="createUriByElement"/>
            </xsl:attribute>
            <rdf:type>
                <xsl:attribute name="rdf:resource"><xsl:value-of select="$discoURI" />Variable</xsl:attribute>
            </rdf:type>            

            <xsl:if test="r:Description">
                <dcterms:description>
                    <xsl:value-of select="r:Description" />
                </dcterms:description>                            
            </xsl:if>
                                    
            <xsl:if test="l:VariableName">
                <dcterms:identifier>
                    <xsl:value-of select="l:VariableName" />
                </dcterms:identifier>
            </xsl:if>
            
            <xsl:if test="r:Label">
                <skos:prefLabel>
                    <xsl:value-of select="r:Label" />
                </skos:prefLabel>
            </xsl:if>
            
            <xsl:if test="l:VariableName">
                <skos:notation>
                    <xsl:value-of select="l:VariableName" />
                </skos:notation>
            </xsl:if>


            <!-- disco:question -->
            <xsl:for-each select="r:QuestionReference">
                <disco:question>
                    <xsl:attribute name="rdf:resource">
                        <xsl:call-template name="createUriByReference"/>
                    </xsl:attribute>
                </disco:question>
            </xsl:for-each>

            <!-- disco:universe -->
            <xsl:for-each select="r:UniverseReference">
                <disco:universe>
                    <xsl:attribute name="rdf:resource">
                        <xsl:call-template name="createUriByReference"/>
                    </xsl:attribute>
                </disco:universe>
            </xsl:for-each>
             
             <xsl:for-each select="l:ConceptReference">
                 <disco:concept>
                     <xsl:attribute name="skos:Concept">
                         <xsl:call-template name="createUriByReference"/>
                     </xsl:attribute>
                 </disco:concept>
             </xsl:for-each>

        </rdf:Description>   
    </xsl:template>
    
    <xsl:template match="l:CategoryScheme">
        <xsl:apply-templates select="l:Category"/>
    </xsl:template>
      
    <xsl:template match="l:Category">
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:call-template name="createUriByElement"/>
            </xsl:attribute>           
            <rdf:type>
                <xsl:attribute name="rdf:resource">http://www.w3.org/2004/02/skos/core#Concept</xsl:attribute>
            </rdf:type>
            <xsl:for-each select="r:Label">
                <skos:prefLabel>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="@xml:lang" />
                    </xsl:attribute>
                    <xsl:value-of select="." />
                </skos:prefLabel>
            </xsl:for-each>
        </rdf:Description>
    </xsl:template>
    
</xsl:stylesheet>