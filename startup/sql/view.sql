create view product_marked_list as
select
  p.id as product_id,
  sum(count) as count
from
  products as p
inner join
  checkin_records as c
on
  p.id = c.product_id
where
  has_marked = true
  and p.visible = true
  and c.visible = true
  and property = 0
group by
  p.id;

create view product_unmarked_list as
select
  p.id as product_id,
  sum(count) as count
from
  products as p
inner join
  checkin_records as c
on
  p.id = c.product_id
where
  has_marked = false
  and p.visible = true
  and c.visible = true
  and property = 0
group by
  p.id;

create view product_unqualified_list as
select
  p.id as product_id,
  sum(count) as count
from
  products as p
inner join
  checkin_records as c
on
  p.id = c.product_id
where
  p.visible = true
  and c.visible = true
  and property > 0
group by
  p.id;

create view product_list as
select
  p.id,
  p.private_id,
  p.name,
  ifnull(m.count, 0) as marked,
  ifnull(u.count, 0) as unmarked,
  ifnull(q.count, 0) as unqualified
from
  products as p
left join
  product_marked_list as m
on
  p.id = m.product_id
left join
  product_unmarked_list as u
on
  p.id = u.product_id
left join
  product_unqualified_list as q
on
  p.id = q.product_id
where
  p.visible = true
order by
  p.private_id;

--

create view checkin_list as
select
  id,
  product_id,
  date,
  property,
  rack_id,
  has_marked,
  count,
  description
from
  checkin_records
where
  visible = true;

--
--
