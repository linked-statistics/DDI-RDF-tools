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
            -disco:representation	union of (skos:ConceptScheme rdfs:Datatype)
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
             
             <!-- disco:concept -->
             <xsl:for-each select="l:ConceptReference">
                 <disco:concept>
                     <xsl:attribute name="skos:Concept">
                         <xsl:call-template name="createUriByReference"/>
                     </xsl:attribute>
                 </disco:concept>
             </xsl:for-each>

             <!-- disco:representation -->             
             <xsl:for-each select="l:Representation/l:CodeRepresentation/r:CodeSchemeReference">
                 <disco:representation>
                     <xsl:attribute name="skos:ConceptScheme">
                         <xsl:call-template name="createUriByReference"/>
                     </xsl:attribute>
                 </disco:representation>
             </xsl:for-each>
             
             <xsl:if test="l:Representation/l:NumericRepresentation">
                 <xsl:variable name="type">
                     <xsl:value-of select="l:Representation/l:NumericRepresentation/@type"/>
                 </xsl:variable>
                 
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
                 </xsl:choose>                 
             </xsl:if>
             
             <xsl:if test="l:Representation/l:TextRepresentation">                 
                 <disco:representation>
                     <xsl:attribute name="rdfs:Datatype">                                
                         <xsl:value-of select="$base-xmlschema-url"/>
                         <xsl:text>string</xsl:text>
                     </xsl:attribute>                         
                 </disco:representation>
             </xsl:if>
             
             <xsl:if test="l:Representation/l:DateTimeRepresentation">                 
                     <xsl:variable name="type">
                         <xsl:value-of select="l:Representation/l:DateTimeRepresentation/@type"/>
                     </xsl:variable>
                 
                 <!-- DateTime  Date  Time  Year  Month  Day  MonthDay  YearMonth  Duration   -->  
                 <xsl:choose>
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
             </xsl:if>
        </rdf:Description>   
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
    
    <xsl:template match="l:CategoryScheme">
        <xsl:apply-templates select="l:Category"/>
    </xsl:template>
    
    <xsl:template match="l:CodeScheme">
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:call-template name="createUriByElement"/>
            </xsl:attribute>           
            <rdf:type>
                <xsl:attribute name="rdf:resource">http://www.w3.org/2004/02/skos/core#ConceptScheme</xsl:attribute>
            </rdf:type>
        </rdf:Description>
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
                    <xsl:call-template name="createLanguageAttribute"/>
                    <xsl:value-of select="." />
                </skos:prefLabel>
            </xsl:for-each>
            <xsl:variable name="categoryID" select="@id" />
            <xsl:for-each select="//l:CodeScheme[l:Code/l:CategoryReference/r:ID =$categoryID]">
                <skos:inScheme>
                    <xsl:attribute name="rdf:resource">
                        <xsl:call-template name="createUriByElement"/>
                    </xsl:attribute>                          
                </skos:inScheme>
            </xsl:for-each>
        </rdf:Description>
    </xsl:template>
    
</xsl:stylesheet>