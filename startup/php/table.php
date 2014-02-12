<?php

mysql_query('drop table if exists customers');
mysql_query(<<<'SQL'
create table customers (
  id int not null auto_increment,
  name varchar(256) not null,

  visible boolean default true,
  primary key (id)
)
SQL
);

mysql_query('drop table outsources');
mysql_query(<<<'SQL'
create table outsources (
  id int not null auto_increment,
  name varchar(256) not null,

  visible boolean default true,
  primary key (id)
)
SQL
);

mysql_query('drop table outsource_purchase_records');
mysql_query(<<<'SQL'
create table outsource_purchase_records (
  id int not null auto_increment,
  customer_id int not null,
  outsource_id int not null,
  price decimal(15, 2) not null,
  count int not null,
  date date not null,
  description varchar(512) default '',

  updated_at timestamp default CURRENT_TIMESTAMP,
  visible boolean default true,

  primary key (id),
  foreign key (customer_id) references customers(id)
    on delete cascade
    on update cascade,
  foreign key (outsource_id) references outsources(id)
    on delete cascade
    on update cascade
)
SQL
);

mysql_query('drop table products');
mysql_query(<<<'SQL'
create table products (
  id int not null auto_increment,
  private_id varchar(64) unique not null,
  name varchar(256) default '',

  visible boolean default true,
  primary key (id)
)
SQL
);

mysql_query('drop table product_checkin_records');
mysql_query(<<<'SQL'
create table product_checkin_records (
  id int not null auto_increment,
  product_id int not null,
  rack_id varchar(128) default '',
  has_markded boolean not null,
  property int default 0,
  count int default 0,
  date date not null,
  description varchar(512) default '',

  updated_at timestamp default CURRENT_TIMESTAMP,
  visible boolean default true,

  primary key (id),
  foreign key (product_id) references products(id)
    on delete cascade
    on update cascade
)
SQL
);

mysql_query('drop table product_deliver_records');
mysql_query(<<<'SQL'
create table product_deliver_records (
  id int not null auto_increment,
  product_id int not null,
  customer_id int not null,
  date date not null,
  price decimal(15, 2) not null,
  count int not null,

  updated_at timestamp default CURRENT_TIMESTAMP,
  visible boolean default true,

  primary key (id),
  foreign key (customer_id) references customers(id)
    on delete cascade
    on update cascade,
  foreign key (product_id) references products(id)
    on delete cascade
    on update cascade
)
SQL
);

?>
