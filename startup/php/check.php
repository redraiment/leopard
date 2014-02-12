<!DOCTYPE html>
<?php
header('Content-Type: text/html; charset=utf-8');
$rs = mysql_query('select id, name from customers');
?>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Database Setup</title>
  </head>
  <body>
    <table border="1" cellpadding="0" cellspacing="0">
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
        </tr>
      </thead>
      <tbody>
        <?php while ($row = mysql_fetch_row($rs)) { ?>
        <tr>
          <td><?= $row[0] ?></td>
          <td><?= $row[1] ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
  </body>
</html>
