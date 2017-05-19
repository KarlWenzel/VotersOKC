--select top 10 * from OkcVoters

--select distinct precinct, right(precinct,3) from okcvoters order by right(precinct,3)

--select distinct muni from okcvoters


select right(precinct,3), count(*) from okcvoters group by right(precinct,3) order by right(precinct,3)

select distinct precinct, right(precinct,3) from okcvoters order by right(precinct,3)
select distinct left(precinct,2) from okcvoters

select last3, count(*) from
(
	select distinct precinct, right(precinct,3) last3 from okcvoters
) tt
group by last3
having count(*) > 1

select * from okcvoters where firstname='Karl' and lastname='Wenzel'