
if not exist rdf-xml mkdir rdf-xml
if not exist rdf-ttl mkdir rdf-ttl

xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/DDI3.1-generic.rdf.xml ../xslt/ddi-to-rdf.xsl ../ddi-examples/DDI3.1-generic.xml
xsltproc --stringparam studyURI http://snd.gu.se/study/1 --output rdf-xml/ISSP.1994.Family-and-changing-gender-roles-II-Sweden.rdf.xml ../xslt/ddi-to-rdf.xsl ../ddi-examples/ISSP.1994.Family-and-changing-gender-roles-II-Sweden.xml
rdfcopy rdf-xml/ISSP.1994.Family-and-changing-gender-roles-II-Sweden.rdf.xml RDF/XML TURTLE > rdf-ttl/ISSP.1994.Family-and-changing-gender-roles-II-Sweden.ttl
rdfcopy rdf-xml/DDI3.1-generic.rdf.xml RDF/XML TURTLE > rdf-ttl/DDI3.1-generic.ttl