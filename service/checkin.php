<?php

require_once('service.php');
process('select id, date, property, rack_id, has_marked, count, description from checkin_list', 'product_id = ' . $_GET['id']);

?>
