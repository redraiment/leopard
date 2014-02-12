
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
