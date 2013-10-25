@echo off
echo 
echo Find questions containing the letter a
for %%x in (sparql/*.rq) do sparql --data=rdf-ttl/ISSP.1994.Family-and-changing-gender-roles-II-Sweden.ttl --query=sparql/%%x
echo 
