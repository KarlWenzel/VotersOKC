library(RODBC)

load.registered.voters = function()
{
  varTypes = c("integer", rep("character",4), "integer", rep("character",43))
  
  CTY09_vr = read.csv(file_CTY09_vr)
  CTY14_vr = read.csv(file_CTY14_vr)
  CTY55_vr = read.csv(file_CTY55_vr)
  CTY63_vr = read.csv(file_CTY63_vr)
  
  conn = odbcConnect(sql_dsn)
  
  sqlDrop(conn, "CTY09_vr", error=FALSE)
  sqlSave(conn, CTY09_vr, rownames=FALSE, varTypes=c(Zip="nvarchar(255)"))
  
  sqlDrop(conn, "CTY14_vr", error=FALSE)
  sqlSave(conn, CTY14_vr, rownames=FALSE, varTypes=c(Zip="nvarchar(255)"))
  
  sqlDrop(conn, "CTY55_vr", error=FALSE)
  sqlSave(conn, CTY55_vr, rownames=FALSE, varTypes=c(Zip="nvarchar(255)"))
  
  sqlDrop(conn, "CTY63_vr", error=FALSE)
  sqlSave(conn, CTY63_vr, rownames=FALSE, varTypes=c(Zip="nvarchar(255)"))
  
  odbcClose(conn)
}

build.okc.voters = function()
{
  conn = odbcConnect(sql_dsn)
  
  sqlDrop(conn, "OkcVoters", error=FALSE)
  sql = paste(readLines(file_create_okcvoters_sql), collapse=" ")
  sqlQuery(conn, sql)
  
  sql = paste(readLines(file_load_okcvoters_sql), collapse=" ")
  sqlQuery(conn, sql)
  
  odbcClose(conn)
}

build.precinct.summary = function()
{
  conn = odbcConnect(sql_dsn)
  odbcClose(conn)
}











