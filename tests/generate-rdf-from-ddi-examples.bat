
if not exist rdf-xml mkdir rdf-xml
if not exist rdf-ttl mkdir rdf-ttl

xsltproc --stringparam studyURI http://my.prefix.com/study/42 --output rdf-xml/DDI3.1-generic.rdf.xml ../xslt/ddi-to-rdf.xsl ../ddi-examples/DDI3.1-generic.xml
xsltproc --stringparam studyURI http://snd.gu.se/stsasd --output rdf-xml/se.gu.snd.sims.ddi3.0856.rdf.xml ../xslt/ddi-to-rdf.xsl ../ddi-examples/se.gu.snd.sims.ddi3.0856.xml
rdfcopy rdf-xml/se.gu.snd.sims.ddi3.0856.rdf.xml RDF/XML TURTLE > rdf-ttl/se.gu.snd.sims.ddi3.0856.ttl
rdfcopy rdf-xml/DDI3.1-generic.rdf.xml RDF/XML TURTLE > rdf-ttl/DDI3.1-generic.ttl