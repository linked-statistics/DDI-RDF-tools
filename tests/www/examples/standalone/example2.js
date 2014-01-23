//Init when the DOM is ready
$(document).ready(function() {
    
    //eventhander for form submit
    $("#searchform").submit(function( event ) {
        
        //get the value in the searchbox
        var search = $('[name="keywords"]').val();
        
        search_questions(search, 'results');
        return false;
    });
});


/**
 * 
 * @param {String} search Keywords 
 * @param {String} target
 * @returns {Void}
 */
function search_questions(search, target){
    //Build the search query (SPARQL)
    var searchQuery = " PREFIX disco:   <http://rdf-vocabulary.ddialliance.org/discovery#> \
                        PREFIX rdfs:    <http://www.w3.org/2000/01/rdf-schema#> \
                        PREFIX dcterms: <http://purl.org/dc/terms/> \
                        SELECT ?study ?questiontext \
                        WHERE {\
                                ?study a disco:Study .\
                                ?study dcterms:title ?title .\
                                ?study disco:questionaire ?questionaire .\
                                ?questionaire disco:question ?question .\
                                ?question disco:questionText ?questiontext\
                                FILTER(langMatches(lang(?questiontext), 'EN'))\
                                FILTER(langMatches(lang(?title), 'EN'))\
                                FILTER regex(?questiontext, '"+search+"', 'i')\
                        }\
                        GROUP BY ?questiontext\
                        LIMIT 10";
    
    $.ajax({
        dataType: "json",
        url: 'http://ddi-rdf.borsna.se/endpoint/?jsonp=?',
        async:   false,
        data: {
            output:'json',
            query: searchQuery
        },
        success: function(data){
            //clear result-div
            $('#'+target).html('');
            
            //loop trough the results
            $.each(data['results']['bindings'], function(index, value){
            
                //get questiontext
                var question = value['questiontext']['value'];
                //get the study
                var study = value['value'];
                
                //add to the result div
                $('<p>'+question+'<br /><a href="'+study+'">go to the study</a></p>').appendTo('#'+target);                
            });
        }
    });
}