@echo off
if not exist rdf-xml mkdir rdf-xml
xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/DDI3.1-generic.rdf.xml 		../xslt/ddi-to-rdf.xsl          ../ddi-examples/DDI3.1-generic.xml

