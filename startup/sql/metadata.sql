insert into products (private_id, name) values ('A001', '五十铃油水分离器');
insert into products (private_id, name) values ('A002', '涨紧轮');
insert into products (private_id, name) values ('B001', '温度传感器');
insert into products (private_id, name) values ('B002', '油压传感器');

insert into checkin_records (product_id, rack_id, has_marked, count, date) values (1, 'A1', false, 100, CURRENT_DATE);
insert into checkin_records (product_id, rack_id, has_marked, count, date) values (1, 'A2', true, 75, CURRENT_DATE);
insert into checkin_records (product_id, rack_id, has_marked, count, date) values (1, 'A1', false, 50, CURRENT_DATE);

-- insert into sell (custom_id, product_id, date, price, count) values (1, 1, '2012-12-12', 12.34, 10);
-- insert into sell (custom_id, product_id, date, price, count) values (1, 2, '2012-12-16', 22.34, 22);
-- insert into sell (custom_id, product_id, date, price, count) values (1, 3, '2012-12-15', 33.34, 30);
-- insert into sell (custom_id, product_id, date, price, count) values (2, 1, '2013-05-01', 20.44, 10);
-- insert into sell (custom_id, product_id, date, price, count) values (2, 2, '2012-12-13', 10.64, 22);
-- insert into sell (custom_id, product_id, date, price, count) values (2, 3, '2013-03-16', 30.74, 20);
-- insert into sell (custom_id, product_id, date, price, count) values (3, 1, '2011-12-12', 12.34, 11);
-- insert into sell (custom_id, product_id, date, price, count) values (3, 2, '2012-05-13', 3, 30);
-- insert into sell (custom_id, product_id, date, price, count) values (3, 3, '2013-01-16', 20.4, 50);
-- insert into collect (custom_id, date, amount) values (1, '2013-12-31', 1000);
-- insert into collect (custom_id, date, amount) values (3, '2014-01-10', 800);
-- insert into collect (custom_id, date, amount) values (3, '2014-01-12', 200);
