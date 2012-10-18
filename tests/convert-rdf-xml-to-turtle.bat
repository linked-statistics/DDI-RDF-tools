@echo off
if not exist rdf-ttl mkdir rdf-ttl
rdfcopy rdf-xml/se.gu.snd.sims.ddi3.0801.rdf.xml RDF/XML TURTLE > rdf-ttl/se.gu.snd.sims.ddi3.0801.ttl
rdfcopy rdf-xml/DDI2.1-generic.rdf.xml RDF/XML TURTLE > rdf-ttl/DDI2.1-generic.ttl
rdfcopy rdf-xml/DDI3.1-generic.rdf.xml RDF/XML TURTLE > rdf-ttl/DDI3.1-generic.ttl