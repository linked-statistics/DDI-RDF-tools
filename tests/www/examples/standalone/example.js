//Init when the DOM is ready
$(document).ready(function() {
    
    //Get the number of studies
    get_count('disco:Study', '#study-count');
});


/**
 * Counts the number of objects with the prefix
 * 
 * @param {String} type
 * @param {String} target
 * @returns {Void}
 */
function get_count(type, target){
    $.ajax({
        dataType: "json",
        url: 'http://ddi-rdf.borsna.se/endpoint/?jsonp=?',
        async:   false,
        data: {
            output:'json',
            query:'PREFIX disco: <http://rdf-vocabulary.ddialliance.org/discovery#> SELECT COUNT(*) AS ?no { ?s a '+type+'}'
        },
        success: function(data){
            $(target).html(data['results'].bindings[0].no.value);
        }
    });
}