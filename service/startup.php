<?php

mysql_connect('localhost', 'redraiment', '') or die('!connect');
mysql_set_charset('utf8');
mysql_query('drop database if exists leopard');
mysql_query('create database leopard character set utf8 collate utf8_general_ci');
mysql_select_db('leopard');

mysql_close();

echo <<<EOF
hello world
nice to meet you!
EOF;
