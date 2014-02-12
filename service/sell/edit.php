<?php
header('Content-Type: text/plain; charset=utf-8');

require_once('../data-source.php');
$dbo = new DBO();

$fn = $_POST['oper'];

if ($fn == 'add') {
  $name = mysql_real_escape_string($_POST['custom']);
  $dbo->exec("insert into custom (name) values ('$name')");
} elseif ($fn == 'del') {
  $id = mysql_real_escape_string($_POST['id']);
  $dbo->exec("update custom set visible = false where id = " . $id);
}

$dbo->close();

?>
