library(RODBC)

load.registered.voters.tables = function()
{
  conn = odbcConnect(sql_dsn)
  
  CTY09_vr = read.csv(file_CTY09_vr)
  sqlDrop(conn, "CTY09_vr", error=FALSE)
  sqlSave(conn, CTY09_vr, rownames=FALSE, varTypes=c(Zip="nvarchar(255)"))
  remove(CTY09_vr)
  
  CTY14_vr = read.csv(file_CTY14_vr)
  sqlDrop(conn, "CTY14_vr", error=FALSE)
  sqlSave(conn, CTY14_vr, rownames=FALSE, varTypes=c(Zip="nvarchar(255)"))
  remove(CTY14_vr)
  
  CTY55_vr = read.csv(file_CTY55_vr)
  sqlDrop(conn, "CTY55_vr", error=FALSE)
  sqlSave(conn, CTY55_vr, rownames=FALSE, varTypes=c(Zip="nvarchar(255)"))
  remove(CTY55_vr)
  
  CTY63_vr = read.csv(file_CTY63_vr)
  sqlDrop(conn, "CTY63_vr", error=FALSE)
  sqlSave(conn, CTY63_vr, rownames=FALSE, varTypes=c(Zip="nvarchar(255)"))
  remove(CTY63_vr)
  
  odbcClose(conn)
}

load.okc.voters.table = function()
{
  conn = odbcConnect(sql_dsn)
  sqlQuery(conn, "DELETE FROM OkcVoters")
  sqlQuery(conn, "EXEC LoadOkcVoters")
  odbcClose(conn)
}

load.voter.history.tables = function()
{
  conn = odbcConnect(sql_dsn)
  
  CTY09_vh = read.csv(file_CTY09_vh)
  sqlDrop(conn, "CTY09_vh", error=FALSE)
  sqlSave(conn, CTY09_vh, rownames=FALSE)
  remove(CTY09_vh)
  
  CTY14_vh = read.csv(file_CTY14_vh)
  sqlDrop(conn, "CTY14_vh", error=FALSE)
  sqlSave(conn, CTY14_vh, rownames=FALSE)
  remove(CTY14_vh)
  
  CTY55_vh = read.csv(file_CTY55_vh)
  sqlDrop(conn, "CTY55_vh", error=FALSE)
  sqlSave(conn, CTY55_vh, rownames=FALSE)
  remove(CTY55_vh)
  
  CTY63_vh = read.csv(file_CTY63_vh)
  sqlDrop(conn, "CTY63_vh", error=FALSE)
  sqlSave(conn, CTY63_vh, rownames=FALSE)
  remove(CTY63_vh)
  
  odbcClose(conn)
}

load.okc.history.table = function()
{
  conn = odbcConnect(sql_dsn)
  sqlQuery(conn, "DELETE FROM OkcVoterHistory")
  sqlQuery(conn, "EXEC LoadOkcVoterHistory")
  odbcClose(conn)
}











