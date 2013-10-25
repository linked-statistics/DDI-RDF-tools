@echo off
SET SAXON=C:\Users\olof\Dropbox\utils\saxon-he\saxon9he.jar

if not exist rdf-xml mkdir rdf-xml
if not exist rdf-ttl mkdir rdf-ttl


for /R "../ddi-examples/DDI3.1/" %%f in (*.xml) do (
	call java -cp %SAXON% net.sf.saxon.Transform -t -s:../ddi-examples/DDI3.1/%%~nf.xml -xsl:../xslt/ddi-to-rdf.xsl -o:rdf-xml/%%~nf.rdf studyURI=http://%%~nf.com/
	rdfcopy rdf-xml/%%~nf.rdf RDF/XML TURTLE > rdf-ttl/%%~nf.ttl
)

