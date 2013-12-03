<?php
require_once('ProgressBar.php');


if(php_sapi_name() == 'cli'){
	$tasks = array();

	//SND
	$files = glob('../ddi/snd/*.{xml}', GLOB_BRACE);
	foreach($files as $file) {
	  $study = GetBetween($file, 'se.gu.snd.sims.ddi3.', '.xml');
	  if (strpos($study, 'series') !== false) {
	    //skipp
	  }else{
		$studyURI = "http://snd.gu.se/catalogue/study/".$study;
		$tasks[] = 'saxon-xslt -o ../rdf/'.$study.'.rdf '.$file.' ../DDI-RDF-tools/xslt/ddi-to-rdf.xsl studyURI='.$studyURI.' subject-prefix-uri=http://ddi-rdf.borsna.se/subject/';
	  }
	}
	
	//DDA
	$files = glob('../ddi/dda/*.{xml}', GLOB_BRACE);
	foreach($files as $file) {
	  $study = GetBetween($file, 'dda-', '.xml');
	  if (strpos($study, 'series') !== false) {
		print "Not a study: ".$study."\n";
	  }else{
		$studyURI = "http://kipon.dda.dk/catalogue/".$study;
		$tasks[] = 'saxon-xslt -o ../rdf/DDA'.$study.'.rdf '.$file.' ../DDI-RDF-tools/xslt/ddi-to-rdf.xsl studyURI='.$studyURI.' subject-prefix-uri=http://ddi-rdf.borsna.se/subject/';
	  }
	}

	$done = 0;
	$fail = 0;
	
	echo ProgressBar::start(count($tasks));
	foreach($tasks as $task){
		echo ProgressBar::next();
		$last_line = system($task, $retval);
		if($retval == 0){
			$done++;
		}else{
			$fail++;
		}
	}
	echo ProgressBar::finish();
}

function GetBetween($content,$start,$end){
    $r = explode($start, $content);
    if (isset($r[1])){
        $r = explode($end, $r[1]);
        return $r[0];
    }
    return '';
}
?>
