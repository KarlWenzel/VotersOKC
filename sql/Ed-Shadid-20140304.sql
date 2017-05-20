select tL.precinct_code as Precinct, isnull(EdVotes,0) as EdVotes, AllVotes
from
(
	select precinct_code, sum(cand_tot_votes) as AllVotes from Vote20140304 
	where race_description = 'FOR MAYOR  CITY OF OKLAHOMA CITY'
	group by precinct_code
) tL
left outer join
(
	select precinct_code, cand_tot_votes as EdVotes from Vote20140304 
	where race_description = 'FOR MAYOR  CITY OF OKLAHOMA CITY'
	and cand_name = 'ED SHADID'
) tR on tL.precinct_code = tR.precinct_code