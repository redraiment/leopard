<?php

class DBO {
  private $client;

  function __construct() {
    $host = "localhost";
    $name = "leopard";
    $user = "redraiment";
    $password = "";

    $this->client = @mysql_connect($host, $user, $password) or die('!connect');
    @mysql_set_charset('utf8', $this->client);
    @mysql_select_db($name, $this->client) or die('!use database');
  }

  function exec($sql) {
    return @mysql_query($sql, $this->client);
  }

  function xml($sql) {
    $rs = $this->exec($sql) or die('!exec');

    $xml = "<?xml version='1.0' encoding='utf-8'?>\n";

    $xml .= "<rows>\n";
    while ($row = @mysql_fetch_row($rs)) {
      $xml .= "<row id='" . $row[0] . "'>";
      for ($i = 1; $i < count($row); $i++) {
        $xml .= "<cell>" . $row[$i] . "</cell>";
      }
      $xml .= "</row>\n";
    }
    $xml .= "</rows>\n";

    @mysql_free_result($rs);

    return $xml;
  }

  function close() {
    @mysql_close($this->client);
  }
};

function with_db($fn) {
  $dbo = new DBO();
  $fn($dbo);
  $dbo->close();
}

?>
