drop database if exists leopard;
create database leopard character set utf8 collate utf8_general_ci;
use leopard;

create table custom (
  id int not null auto_increment,
  name varchar(16) not null,
  visible boolean default true,
  primary key (id)
);
insert into custom (name) values ('张泽鹏');
insert into custom (name) values ('redraiment');
insert into custom (name) values ('Joe');

create table product (
  id int not null auto_increment,
  name varchar(255) not null,
  visible boolean default true,
  primary key (id)
);
insert into product (name) values ('五十铃油水分离器');
insert into product (name) values ('涨紧轮');
insert into product (name) values ('温度传感器');

create table sell (
  id int not null auto_increment,
  custom_id int not null,
  product_id int not null,
  date date not null,
  price decimal(15, 2) not null,
  count int not null,
  visible boolean default true,
  primary key (id),
  foreign key (custom_id) references custom(id)
    on delete cascade
    on update cascade,
  foreign key (product_id) references product(id)
    on delete cascade
    on update cascade
);
insert into sell (custom_id, product_id, date, price, count) values (1, 1, '2012-12-12', 12.34, 10);
insert into sell (custom_id, product_id, date, price, count) values (1, 2, '2012-12-16', 22.34, 22);
insert into sell (custom_id, product_id, date, price, count) values (1, 3, '2012-12-15', 33.34, 30);
insert into sell (custom_id, product_id, date, price, count) values (2, 1, '2013-05-01', 20.44, 10);
insert into sell (custom_id, product_id, date, price, count) values (2, 2, '2012-12-13', 10.64, 22);
insert into sell (custom_id, product_id, date, price, count) values (2, 3, '2013-03-16', 30.74, 20);
insert into sell (custom_id, product_id, date, price, count) values (3, 1, '2011-12-12', 12.34, 11);
insert into sell (custom_id, product_id, date, price, count) values (3, 2, '2012-05-13', 3, 30);
insert into sell (custom_id, product_id, date, price, count) values (3, 3, '2013-01-16', 20.4, 50);

create table collect (
  id int not null auto_increment,
  custom_id int not null,
  date date not null,
  amount decimal(15, 2) not null,
  visible boolean default true,
  primary key (id),
  foreign key (custom_id) references custom(id)
    on delete cascade
    on update cascade
);
insert into collect (custom_id, date, amount) values (1, '2013-12-31', 1000);
insert into collect (custom_id, date, amount) values (3, '2014-01-10', 800);
insert into collect (custom_id, date, amount) values (3, '2014-01-12', 200);

create view custom_collect_list as
select
  custom_id,
  sum(amount) as amount
from
  collect
where
  visible = true
group by
  custom_id;

create view custom_sell_list as
select
  custom_id,
  sum(price * count) as total
from
  sell
where
  visible = true
group by
  custom_id;

create view custom_list as
select
  c.id,
  c.name,
  ifnull(s.total, 0) as total,
  ifnull(o.amount, 0) as amount,
  ifnull(s.total, 0) - ifnull(o.amount, 0) as rest
from
  custom as c
left join
  custom_collect_list as o
on
  c.id = o.custom_id
left join
  custom_sell_list as s
on
  c.id = s.custom_id
where
  visible = true
order by
  ifnull(s.total, 0) - ifnull(o.amount, 0) desc,
  c.id asc;

create view collect_list as
select
  c.id,
  c.date,
  c.amount,
  t.id as custom
from
  collect as c
inner join
  custom as t
on
  c.custom_id = t.id
  and t.visible = true
where
  c.visible = true
order by
  c.date desc,
  c.id desc;
