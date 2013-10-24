<?xml version="1.0" encoding="UTF-8"?>
<!-- ddi-to-rdf.xsl -->
<!-- converts a DDI-codebook/lifecycle instance to RDF-XML -->

<!-- DDI Ontology draft: https://raw.github.com/linked-statistics/disco-spec/master/discovery.ttl -->

<!--to validate output: -->
<!--http://www.w3.org/RDF/Validator/ -->

<!-- developed by: -->
<!-- Bosch, Thomas <Thomas.Bosch at gesis.org> -->
<!-- Olsson, Olof <olof.olsson at snd.gu.se> -->
<!-- Zapilko, Benjamin <Benjamin.Zapilko at gesis.org> -->

<!-- read: -->
<!-- $studyURI [params] -->

<!-- set: -->
<!-- $DiscoURI -->

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
                xmlns:ddicb     = "http://www.icpsr.umich.edu/DDI">

    <!-- ================================================== -->
    <!-- import                                             -->
    <!-- ===================================================-->
    <xsl:import href="ddi-lifecycle/ddi3-1-to-rdf.xsl"/>
    <xsl:import href="ddi-codebook/ddi2-1-to-rdf.xsl"/>   
    <xsl:import href="ddi-lifecycle/ddi3-1-util.xsl"/>
    
    <!-- ================================================== -->
    <!-- output options                                -->
    <!-- ===================================================-->
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <!-- ================================================== -->
    <!-- setup                                              -->
    <!-- ===================================================-->
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <!-- ================================================== -->
    <!-- params                                             -->
    <!-- ===================================================-->
    <!-- prefix for elements uri:s eg: http://i.am.a.url.com/study/123 -->
    <xsl:param name="studyURI">http://www.example.com/</xsl:param>

    <!-- ================================================== -->
    <!-- variables                                          -->
    <!-- ================================================== -->
    <xsl:variable name="discoURI">http://rdf-vocabulary.ddialliance.org/discovery#</xsl:variable>
    
    
    <!-- main template -->
    <!-- match: / -->
    <xsl:template match="/">
        <xsl:apply-templates select="ddilc:DDIInstance" />
        <xsl:apply-templates select="ddicb:codeBook" />
    </xsl:template>
</xsl:stylesheet>
