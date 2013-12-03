<?php
require_once('ProgressBar.php');

if(php_sapi_name() == 'cli'){
	$tasks = array();

	$files = glob('../rdf/*.{rdf}', GLOB_BRACE);
	foreach($files as $file) {
		$tasks[] = 'php import-cli.php "LOAD <file:///home/olof/public_html/ddi-rdf/rdf/'.basename($file).'>"';
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
	echo "Done: $done \n";
	echo "Failed: $fail \n";
	
}else{
	echo "This can only be done via CLI";
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
