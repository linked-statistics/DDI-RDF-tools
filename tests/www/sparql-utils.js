function addCommas(nStr){
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}

function sparqlResultToTable(data){
  var result = '<table class="table"><thead><tr>';
  var header = Array();
  for(var i = 0; i<  data.head.vars.length; i++) {
	header.push(data.head.vars[i]);
	result += '<th>'+data.head.vars[i]+'</th>';
  }
  var urlregex = new RegExp("^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?");
  
  result += '</tr></thead><tbody>';
  for(var i = 0; i <  data.results.bindings.length; i++) {
	result += '<tr>';
	for(var j = 0; j <  header.length; j++) {
	   var value = '<span class="value">'+data.results.bindings[i][header[j]].value+'</span>';
	   if(data.results.bindings[i][header[j]]['xml:lang']){
			value = '<img class="image icon" src="/images/languages/'+data.results.bindings[i][header[j]]['xml:lang']+'.gif" /> '+value;
	   }
	   if(urlregex.test(data.results.bindings[i][header[j]].value)){
		 result += '<td class="'+header[j]+'"><a href="'+data.results.bindings[i][header[j]].value+'">'+data.results.bindings[i][header[j]].value+'</a></td>';
	   }else{
		 result += '<td class="'+header[j]+'">'+value+'</td>';
	   }
	}
	result += '</tr>';
  }						  
  result += '</tbody></table>';
  return result;
}