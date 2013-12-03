<?php
/* Include database config */
include_once('../config.php');

/* ARC2 static class inclusion */ 
include_once('../libraries/arc2-2.2.3/ARC2.php');


/* instantiation */
$ep = ARC2::getStoreEndpoint($config);

if (!$ep->isSetUp()) {
  $ep->setUp(); /* create MySQL tables */
}

/* request handling */
$ep->go();
?>