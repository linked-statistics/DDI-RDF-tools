Tools, vocabularies and other stuff for an RDF representation of DDI

h2. Mapping DDI to RDF Schema

The plan is the following:

h3. Conceptual mapping from DDI XML to RDF Schema

* Determine the conceptual mappings from XML elements in DDI to RDF classes and properties
* Only a selected subset of DDI's elements is mapped, based on a discovery use case
* Some elements are mapped to new RDF classes and properties in our new vocabulary
* Some elements are mapped to existing vocabularies like SKOS, FOAF, DC, geo

h3. Write down conceptual mapping in declarative form

* Invent a simple XML format to express the conceptual mapping

h3. Instance translator

* The instance translator is an auto-generated XSLT that converts DDI instance XML to RDF
* It is auto-generated from the conceptual mapping XML using another XSLT

h3. RDFS generator

* The RDFS generator takes the conceptual mapping XML and generates RDF Schema documentation
* It may also read from the DDI XML schema files to read the element documentation

h3. Open issues

* Should we in parallel hand-write a first version of the Instance Translator?
* Should we start by focusing on DDI 2.X or 3.X?
* Would we do two conceptual mappings, one for 2.X and one for 3.X?
