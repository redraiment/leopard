<?php

function with_database($fn) {
  $host = "localhost";
  $name = "leopard";
  $user = "redraiment";
  $password = "";

  $dbo = mysql_connect($host, $user, $password) or die('!connect');
  mysql_set_charset('utf8', $dbo);
  mysql_select_db($name, $dbo) or die('!use database');

  $value = $fn($dbo);

  mysql_close($dbo);

  return $value;
}

function with_query($sql, $fn) {
  return with_database(function($dbo) use($sql, $fn) {
    $rs = mysql_query($sql, $dbo);
    $value = $fn($rs);
    mysql_free_result($rs);
    return $value;
  });
}

function with_query_xml($sql, $fn) {
  return with_query($sql, function($rs) use($fn) {
    $xml = "<?xml version='1.0' encoding='utf-8'?>\n";

    $xml .= "<rows>\n";
    while ($row = mysql_fetch_row($rs)) {
      $xml .= "<row id='" . $row[0] . "'>";
      for ($i = 1; $i < count($row); $i++) {
        $xml .= "<cell>" . $row[$i] . "</cell>";
      }
      $xml .= "</row>\n";
    }
    $xml .= "</rows>\n";

    return $fn($xml);
  });
}

?>
