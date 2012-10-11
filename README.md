Tools, vocabularies and other stuff for an RDF representation of DDI

## Mapping DDI to RDF Schema

The plan is the following:

### Conceptual mapping from DDI XML to RDF Schema

* Determine the conceptual mappings from XML elements in DDI to RDF classes and properties
* Only a selected subset of DDI's elements is mapped, based on a discovery use case
* Some elements are mapped to new RDF classes and properties in our new vocabulary
* Some elements are mapped to existing vocabularies like SKOS, FOAF, DC, geo

### Write down conceptual mapping in declarative form

* Invent a simple XML format to express the conceptual mapping

### Instance translator

* The instance translator is an auto-generated XSLT that converts DDI instance XML to RDF
* It is auto-generated from the conceptual mapping XML using another XSLT

### RDFS generator

* The RDFS generator takes the conceptual mapping XML and generates RDF Schema documentation
* It may also read from the DDI XML schema files to read the element documentation

### Open issues

* Should we in parallel hand-write a first version of the Instance Translator?
* Should we start by focusing on DDI 2.X or 3.X?
* Would we do two conceptual mappings, one for 2.X and one for 3.X?

## Acknowledgements

This repository is the result of work that was started at the workshop
*Semantic Statistics for Social, Behavioural, and Economic Sciences:
Leveraging the DDI Model for the Web* at Dagstuhl, 11-16 September 2011.

http://www.dagstuhl.de/11372

Contributors include:

* Thomas Bosch
* Benjamin Zapilko
* Olof Olsson

The workshop was organized by:

* Richard Cyganiak (DERI, National University of Ireland - Galway, IE)
* Arofan Gregory (Open Data Foundation - Tucson, US)
* Wendy Thomas (Population Center, University of Minnesota, US)
* Joachim Wackerow (GESIS - Leibniz Institute for the Social Sciences, DE)
