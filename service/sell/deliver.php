<?php
header('Content-Type: text/xml; charset=utf-8');

require_once('../data-source.php');

$id = $_GET['id'];
$dbo = new DBO();
echo $dbo->xml("select s.id, s.date, p.name, s.price, s.count from sell as s inner join product as p on s.product_id = p.id where s.custom_id = $id and s.visible = true and p.visible = true order by s.date desc");
$dbo->close();

?>
