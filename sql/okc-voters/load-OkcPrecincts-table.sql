select 
	t1.Precinct, 
	t1.RegisteredVoters, 
	isnull(t2.RepublicanVoters, 0) as RepublicanVoters, 
	100 * isnull(t2.RepublicanVoters, 0) / nullif(t1.RegisteredVoters,0) as PercentRepublican,
	isnull(t3.DemocratVoters, 0) as DemocratVoters,
	100 * isnull(t3.DemocratVoters, 0) / nullif(t1.RegisteredVoters,0) as PercentDemocrat, 
	isnull(t4.LibertarianVoters, 0) as LibertarianVoters, 
	100 * isnull(t4.LibertarianVoters, 0) / nullif(t1.RegisteredVoters,0) as PercentLibertarian,
	isnull(t5.IndependentVoters, 0) as IndependentVoters,
	100 * isnull(t5.IndependentVoters, 0) / nullif(t1.RegisteredVoters,0) as PercentIndependent
 from
	(select Precinct, count(*) as RegisteredVoters from OkcVoters group by Precinct) as t1
	left outer join (select Precinct, count(*) as RepublicanVoters from OkcVoters where PolitalAff='REP' group by Precinct) as t2 on t1.Precinct = t2.Precinct
	left outer join (select Precinct, count(*) as DemocratVoters from OkcVoters where PolitalAff='DEM' group by Precinct) as t3 on t1.Precinct = t3.Precinct
	left outer join (select Precinct, count(*) as LibertarianVoters from OkcVoters where PolitalAff='LIB' group by Precinct) as t4 on t1.Precinct = t4.Precinct
	left outer join (select Precinct, count(*) as IndependentVoters from OkcVoters where PolitalAff='IND' group by Precinct) as t5 on t1.Precinct = t5.Precinct

