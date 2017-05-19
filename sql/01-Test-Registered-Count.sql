declare @voterCount int
select @voterCount = count(*) from CTY09_vr where Muni = 'CITY OF OKLAHOMA CITY AT LARGE'
select @voterCount = @voterCount + count(*) from CTY14_vr where Muni = 'CITY OF OKLAHOMA CITY AT LARGE'
select @voterCount = @voterCount + count(*) from CTY55_vr where Muni = 'CITY OF OKLAHOMA CITY AT LARGE'
select @voterCount = @voterCount + count(*) from CTY63_vr where Muni = 'CITY OF OKLAHOMA CITY AT LARGE'
select @voterCount
