@echo off
if not exist rdf-xml mkdir rdf-xml
if not exist rdf-ttl mkdir rdf-ttl
xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/DDI3.1-generic.rdf.xml 		../xslt/ddi-to-rdf.xsl          ../ddi-examples/DDI3.1-generic.xml
rdfcopy rdf-xml/DDI3.1-generic.rdf.xml RDF/XML TURTLE > rdf-ttl/DDI3.1-generic.ttl
