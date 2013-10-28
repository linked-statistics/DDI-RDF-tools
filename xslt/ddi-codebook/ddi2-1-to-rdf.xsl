<?xml version="1.0" encoding="UTF-8"?>
<!-- ddi2-1-to-rdf.xsl -->
<!-- converts a DDI 2.1 intance to RDF -->

<!-- to validate output: -->
<!-- http://www.w3.org/RDF/Validator/ -->

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
  xmlns:ddicb     ="http://www.icpsr.umich.edu/DDI">

  <!-- ================================================== -->
  <!-- imports                                            -->
  <!-- ================================================== -->
  <xsl:import href="ddi2-1_datacollection.xsl"/>
  <xsl:import href="ddi2-1_logicalproduct.xsl"/>

</xsl:stylesheet>
