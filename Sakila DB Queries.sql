#nama lengkap
select concat(first_name, ' ', last_name) 'Actor Name' from actor;

#aktor dengan bayaran tertinggi di tahun 2005
select s.staff_id, s.first_name, s.last_name,  coalesce(concat('$', format(sum(p.amount), 2)), '$0') as amount 
from
staff  as s
join
payment as p
on
s.staff_id = p.staff_id
where
p.payment_date >= '2005-01-01 00:00:00'
and
p.payment_date <= '2005-12-31 00:00:00'
group by s.staff_id;

#top 3 aktor dengan film terbanyak
select actor.actor_id, actor.first_name, actor.last_name,
       count(actor_id) as film_count
from actor join film_actor using (actor_id)
group by actor_id
order by film_count desc limit 3;

#top 5 rata-rata durasi film terlama berdasarkan kategori
select category.name, avg(length)
from film join film_category using (film_id) join category using (category_id)
group by category.name
having avg(length) > (select avg(length) from film)
order by avg(length) desc;

#subquery untuk menampilkan semua aktor yang ada pada film Clash Freddy
select first_name, last_name
from actor 
where actor_id in (
select actor_id
from film_actor
where film_id in (
select film_id from film where lower(title) = lower('Clash Freddy')
		)
);

# durasi film terlama
select max(length) from film

#durasi produksi film terendah
select min(length) from film

#jumlah pembayaran
select sum(amount) from payment

#jenis-jenis rating
select distinct rating from film

#top 3 genre film berdasarkan pendapa
select cat.name category_name, sum( IFNULL(pay.amount, 0) ) revenue from category cat
left join film_category flm_cat on cat.category_id = flm_cat.category_id
left join film fil
on flm_cat.film_id = fil.film_id
left join inventory inv on fil.film_id = inv.film_id
left join rental ren on inv.inventory_id = ren.inventory_id
left join payment pay on ren.rental_id = pay.rental_id
group by cat.name
order by revenue desc limit 3;