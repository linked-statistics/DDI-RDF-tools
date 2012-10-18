@echo off
if not exist rdf-xml mkdir rdf-xml
xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/se.gu.snd.sims.ddi3.0801.rdf.xml ../ddi-lifecycle/xsl/ddi3-1-to-rdf.xsl 	../ddi-examples/se.gu.snd.sims.ddi3.0801.xml 
xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/DDI3.1-generic.rdf.xml 			../ddi-lifecycle/xsl/ddi3-1-to-rdf.xsl 	../ddi-examples/DDI3.1-generic.xml
xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/DDI2.1-generic.rdf.xml 			../ddi-codebook/xsl/ddi2-1-to-rdf.xsl 	../ddi-examples/DDI2.1-generic.xml

