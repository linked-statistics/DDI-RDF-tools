@echo off
if not exist rdf-xml mkdir rdf-xml
xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/se.gu.snd.sims.ddi3.0801.rdf.xml ../xslt/ddi-lifecycle/ddi3-1-to-rdf.xsl 	../ddi-examples/se.gu.snd.sims.ddi3.0801.xml 
xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/DDI3.1-generic.rdf.xml 		../xslt/ddi-lifecycle/ddi3-1-to-rdf.xsl 	../ddi-examples/DDI3.1-generic.xml
xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/DDI3.1-questionExample.rdf.xml 	../xslt/ddi-lifecycle/ddi3-1-to-rdf.xsl 	../ddi-examples/DDI3.1-questionExample.xml
xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/DDI2.1-generic.rdf.xml 		../xslt/ddi-codebook/ddi2-1-to-rdf.xsl          ../ddi-examples/DDI2.1-generic.xml

