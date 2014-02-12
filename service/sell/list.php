<?php
header('Content-Type: text/xml; charset=utf-8');

require_once('../data-source.php');

$dbo = new DBO();
echo $dbo->xml('select c.id, c.name, sum(s.price * s.count) as total, 0 as amount, 0 as rest from custom c inner join sell s on c.id = s.custom_id inner join product p on p.id = s.product_id where c.visible = true and p.visible = true and s.visible = true group by c.id, c.name order by c.id');
$dbo->close();

?>
