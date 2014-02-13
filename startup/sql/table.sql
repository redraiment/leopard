drop database if exists leopard;
create database leopard character set utf8 collate utf8_general_ci;
use leopard;

--
--

create table products (
  id int not null auto_increment,
  private_id varchar(64) unique not null,
  name varchar(256) default '',

  visible boolean default true,
  primary key (id)
);

create table checkin_records (
  id int not null auto_increment,
  product_id int not null,
  rack_id varchar(128) default '',
  has_marked boolean not null,
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
);

--
--

create table vendees (
  id int not null auto_increment,
  name varchar(256) not null,

  visible boolean default true,
  primary key (id)
);

create table deliver_records (
  id int not null auto_increment,
  product_id int not null,
  vendee_id int not null,
  date date not null,
  price decimal(15, 2) not null,
  count int not null,

  updated_at timestamp default CURRENT_TIMESTAMP,
  visible boolean default true,

  primary key (id),
  foreign key (vendee_id) references vendees(id)
    on delete cascade
    on update cascade,
  foreign key (product_id) references products(id)
    on delete cascade
    on update cascade
);

--
--

create table venders (
  id int not null auto_increment,
  name varchar(256) not null,

  visible boolean default true,
  primary key (id)
);

create table services (
  id int not null auto_increment,
  name varchar(256) not null,

  visible boolean default true,
  primary key (id)
);

create table purchase_records (
  id int not null auto_increment,
  vender_id int not null,
  service_id int not null,
  price decimal(15, 2) not null,
  count int not null,
  date date not null,
  description varchar(512) default '',

  updated_at timestamp default CURRENT_TIMESTAMP,
  visible boolean default true,

  primary key (id),
  foreign key (vender_id) references venders(id)
    on delete cascade
    on update cascade,
  foreign key (service_id) references services(id)
    on delete cascade
    on update cascade
);
