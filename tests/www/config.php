<?php
/* MySQL and endpoint configuration */ 
$config = array(
  /* db */
  'db_host' => 'localhost', /* optional, default is localhost */
  'db_name' => 'dbname',
  'db_user' => 'dbuser',
  'db_pwd' => 'dbpassword',

  /* store name */
  'store_name' => 'storename',

  /* endpoint */
  'endpoint_features' => array(
    'select', 'construct', 'ask', 'describe', 
    'load', 'insert', 'delete', 
    'dump' /* dump is a special command for streaming SPOG export */
  ),
  'endpoint_timeout' => 120, /* not implemented in ARC2 preview */
  'endpoint_read_key' => '', /* optional */
  'endpoint_write_key' => 'somekey', /* optional, but without one, everyone can write! */
  'endpoint_max_limit' => 25000, /* optional */
);


?>