<?php

$cfg = json_decode(getenv("VCAP_SERVICES"))->{'mysql-5.1'}[0]->{'credentials'};
$host = $cfg->{'host'};
$user = $cfg->{'user'};
$password = $cfg->{'password'};

mysql_connect($host, $user, $password) or die('!connect');
mysql_set_charset('utf8');

$name = $cfg->{'name'};
mysql_select_db($name) or die('!use database');

require_once('table.php');
require_once('metadata.php');
require_once('check.php');

mysql_close();

?>
