<?php

header('Content-Type: text/xml; charset=utf-8');
require_once('db.php');

// list
function service_list_condition($query) {
  if ($query != '') {
    $query = " where " . $query;
  }

  if ($_GET['_search'] == 'true') {
    if ($query == '') {
      $query = " where " . $_GET['searchField'];
    } else {
      $query .= " and " . $_GET['searchField'];
    }

    $value = $_GET['searchString'];

    switch($_GET['searchOper']) {
    // string
    case 'cn':
      $query .= " like '%$value%'";
      break;
    case 'nc':
      $query .= " not like '%$value%'";
      break;

    // number
    case 'eq':
      $query .= " = $value";
      break;
    case 'ne':
      $query .= " != $value";
      break;
    case 'bw':
      $query .= " >= $value";
      break;
    case 'bn':
      $query .= " < $value";
      break;
    case 'ew':
      $query .= " <= $value";
      break;
    case 'en':
      $query .= " > $value";
      break;
    }
  }

  return $query;
}

function service_list_sort() {
  $query = '';
  if ($_GET['sidx']) {
    $query .= ' order by ' . $_GET['sidx'];
    if ($_GET['sord']) {
      $query .= ' ' . $_GET['sord'];
    }
  }
  return $query;
}

function service_list_pager() {
  $query = '';
  if ($_GET['rows']) {
    $page = $_GET['page']? $_GET['page']: '1';
    $rows = intval($_GET['rows']);
    $offset = $rows * (intval($page) - 1);
    $query .= " limit $rows offset $offset";
  }
  return $query;
}

function service_list($query, $condition) {
  $query .= service_list_condition($condition);
  $query .= service_list_sort();
  $query .= service_list_pager();

  with_query_xml($query, function($xml) {
    echo $xml;
  });
}

// edit

function service_edit($query) {
  echo "edit $query";
}

// entry
function process($query, $condition) {
  if ($_POST['oper']) {
    service_edit($query);
  } else {
    service_list($query, $condition);
  }
}

?>
