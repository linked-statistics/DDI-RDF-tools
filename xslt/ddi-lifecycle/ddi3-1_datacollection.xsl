<?xml version="1.0" encoding="UTF-8"?>
<!-- ddi3-1-to-rdf.xsl -->
<!-- converts a DDI 3.1 intance to RDF -->

<!-- Assigned : Olof Olsson -->

<xsl:stylesheet version="2.0" 
  xmlns:xsl       ="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdf       ="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:si        ="http://www.w3schools.com/rdf/" 
  xmlns:owl       ="http://www.w3.org/2002/07/owl#" 
  xmlns:skosclass ="http://ddialliance.org/ontologies/skosclass"
  xmlns:xml       ="http://www.w3.org/XML/1998/namespace" 
  xmlns:rdfs      ="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:xsi       ="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:skos      ="http://www.w3.org/2004/02/skos/core#" 
  xmlns:dc        ="http://purl.org/dc/elements/1.1/"
  xmlns:dcterms   ="http://purl.org/dc/terms/" 
  xmlns:disco     ="http://rdf-vocabulary.ddialliance.org/discovery#"
  xmlns:ddi       ="http://ddialliance.org/data/" 
  xmlns:ddilc     ="ddi:instance:3_1"
  xmlns:g         ="ddi:group:3_1"
  xmlns:d         ="ddi:datacollection:3_1"
  xmlns:dce       ="ddi:dcelements:3_1"
  xmlns:c         ="ddi:conceptualcomponent:3_1"
  xmlns:xhtml     ="http://www.w3.org/1999/xhtml"
  xmlns:a         ="ddi:archive:3_1"
  xmlns:m1        ="ddi:physicaldataproduct/ncube/normal:3_1"
  xmlns:m2        ="ddi:physicaldataproduct/ncube/tabular:3_1"
  xmlns:o         ="ddi:organizations:3_1"
  xmlns:l         ="ddi:logicalproduct:3_1"
  xmlns:m3        ="ddi:physicaldataproduct/ncube/inline:3_1"
  xmlns:pd        ="ddi:physicaldataproduct:3_1"
  xmlns:cm        ="ddi:comparative:3_1"
  xmlns:s         ="ddi:studyunit:3_1"
  xmlns:r         ="ddi:reusable:3_1"
  xmlns:pi        ="ddi:physicalinstance:3_1"
  xmlns:ds        ="ddi:dataset:3_1"
  xmlns:pr        ="ddi:profile:3_1">

  <!-- =================== -->
  <!-- output options      -->
  <!-- =================== -->
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>


  <!-- =========================== -->
  <!-- template match d:instrument -->
  <!-- =========================== -->
  <xsl:template match="d:Instrument">
    <rdf:Desciption>
      <xsl:attribute name="rdf:about">
        <xsl:call-template name="createUriByElement"/>
      </xsl:attribute>    
      <rdf:type>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$discoURI" />Instrument</xsl:attribute>
      </rdf:type>            
    </rdf:Desciption>
  </xsl:template>

  <!-- ==================================================== -->
  <!-- template match d:QuestionItem|d:MultipleQuestionItem -->
  <!-- ==================================================== -->
  <xsl:template match="d:QuestionItem|d:MultipleQuestionItem">
    <rdf:Description>
      <xsl:attribute name="rdf:about">
        <xsl:call-template name="createUriByElement"/>
      </xsl:attribute>        
      <rdf:type>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$discoURI" />Question</xsl:attribute>
      </rdf:type>
            
      <!-- QuestionItemName -->
      <xsl:for-each select="d:QuestionItemName|d:MultipleQuestionItemName">
        <skos:prefLabel>
          <xsl:attribute name="xml:lang">
            <xsl:value-of select="@xml:lang" />
          </xsl:attribute>
          <xsl:value-of select="." />
        </skos:prefLabel>
      </xsl:for-each>
            
      <!-- Question Concept -->
      <xsl:for-each select="r:ConceptReference">
        <disco:concept>
          <xsl:attribute name="rdf:resource">
            <xsl:call-template name="createUriByReference"/>
          </xsl:attribute>
        </disco:concept>
      </xsl:for-each>
            
      <!-- QuestionText -->
      <xsl:for-each select="d:QuestionText">
        <disco:questionText>
          <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang" /></xsl:attribute>
          <xsl:value-of select="d:LiteralText/d:Text" />
        </disco:questionText>                
      </xsl:for-each>
            
      <!-- currently no response domain in disco spec -see bug on git hub ddi disco -->
      <!-- Response Domain -->            

      <!--xsl:apply-templates select="d:CodeDomain" />
            
      <xsl:if test="d:NumericDomain">
        <xsl:call-template name="createDiscoRepresentation">
                    <xsl:with-param name="type">
                        <xsl:value-of select="d:NumericDomain/@type"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            
            <xsl:if test="d:TextDomain">
                <xsl:call-template name="createDiscoRepresentation">
                    <xsl:with-param name="type">
                        <xsl:text>String</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            
            <xsl:if test="d:DateTimeDomain">
              <xsl:call-template name="createDiscoRepresentation">
                <xsl:with-param name="type">
                    <xsl:value-of select="d:DateTimeDomain/@type"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if-->
      
    </rdf:Description>
  </xsl:template>  

  <!-- =========================== -->
  <!-- template match d:CodeDomain -->
  <!-- =========================== -->
  <xsl:template match="d:CodeDomain">
    <xsl:variable name="codeSchemeSchemeID" select="r:CodeSchemeReference/r:ID"/>
       
    <xsl:for-each select="r:CodeSchemeReference">
      <disco:hasResponseDomain>
        <xsl:attribute name="rdf:resource">
          <xsl:call-template name="createUriByReference"/>
        </xsl:attribute>                        
      </disco:hasResponseDomain>                
    </xsl:for-each>      
  </xsl:template>
  
</xsl:stylesheet>
