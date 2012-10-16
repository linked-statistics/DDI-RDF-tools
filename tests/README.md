Test for the DDI-RDF xslt maping

## Required tools
xsltproc
jena

## Installing jena
download: http://jena.apache.org/download/
extract the content to a folder

set enviroment variables:
	linux: 
	export JENAROOT=/home/somebody/dev/apache-jena
	PATH=$JENAROOT/bin:$PATH
	
	windows:
	use this guide http://searchsystemschannel.techtarget.com/feature/Setting-Windows-7-environment-variables
	add the user variable JENAROOT set the value to the path for jena
	add the folowing in the end of the variable Path: ;C:\path\to\jena

## Run the examples
windows:
	generate-rdf-from-ddi-examples.bat (requires xsltproc) will create RDF/XML from the DDI-examples
	convert-rdf-xml-to-turtle.bat (requires jana) will convert the oRDF/XML to TURTLE
	