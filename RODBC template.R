# RODBC Example
# import 2 tables (Crime and Punishment) from a DBMS
# into R data frames (and call them crimedat and pundat)

### BDG ###
library(RODBC)
#myconn hold a reference to a connection
#create/configure DSN (ODBC connection with specific DB)
myconn <-odbcConnect("dsn", uid="id", pwd="mypws")

manpower_new = sqlQuery(myconn, 'SELECT * FROM "RM"."MANPOWER_NEW"')
View(manpower_new)

#directly fetch a table using sqlFetch
#crimedat is an R dataframe
crimedat <- sqlFetch(myconn, "Crime")
crimedat = sqlFetch(myconn, "select * from tableName")
view(crimedat)
odbcClose(myconn)
#####

#execute a query and retrieve the rowset
pundat = sqlQuery(myconn, "SELECT * FROM Products WHERE CategoryID = 3")
pundat <- sqlQuery(myconn, "select * from Punishment")
#specify a max number of rows to retrieve
pundat = sqlQuery(myconn, "SELECT * FROM Products", max=5)
#get next 10
pundat = sqlGetResults(myconn, max=10)

close(myconn) 
### FUNCTIONS ###
#odbcClose(channel)
#odbcConnect(dsn, uid = "", pwd = "", ...)
#odbcDataSources(type = c("all", "user", "system"))   -->List known ODBC data sources
#odbcGetInfo(channel) -->Request information on an ODBC connection.
#setSqlTypeInfo(driver, value)  -->Specify or retrieve a mapping of R types to DBMS datatypes
#getSqlTypeInfo(driver)  -->DBMS_name as returned by odbcGetInfo
#sqlColumns(channel, sqtable, errors = FALSE, as.is = TRUE,special = FALSE, catalog = NULL, schema = NULL,literal = FALSE)
#sqlPrimaryKeys(channel, sqtable, errors = FALSE, as.is = TRUE,catalog = NULL, schema = NULL)
#sqlCopy(channel, query, destination, destchannel = channel,verbose = FALSE, errors = TRUE, ...)
#sqlCopyTable(channel, srctable, desttable, destchannel = channel, verbose = FALSE, errors = TRUE)
#sqlClear(channel, sqtable, errors = TRUE) -->deletes all the rows of the table sqtable.
#sqlDrop(channel, sqtable, errors = TRUE) -->removes the table sqtable (if permitted).
#sqlFetch(channel, sqtable, ..., colnames = FALSE, rownames = TRUE)
#sqlFetchMore(channel, ..., colnames = FALSE, rownames = TRUE)  -->Read some or all of a table from an ODBC database into a data frame.
#sqlQuery(channel, query, errors = TRUE, ..., rows_at_time)
#sqlGetResults(channel, as.is = FALSE, errors = FALSE,
              #max = 0, buffsize = 1000,
              #nullstring = NA_character_, na.strings = "NA",
              #believeNRows = TRUE, dec = getOption("dec"),
              #stringsAsFactors = default.stringsAsFactors()) --> Submit an SQL query to an ODBC database, and retrieve the results.
#sqlSave(channel, dat, tablename = NULL, append = FALSE,
  #rownames = TRUE, colnames = FALSE, verbose = FALSE,
  #safer = TRUE, addPK = FALSE, typeInfo, varTypes,
  #fast = TRUE, test = FALSE, nastring = NULL)  --> Write or update a table in an ODBC database
#sqlUpdate(channel, dat, tablename = NULL, index = NULL,
          #verbose = FALSE, test = FALSE, nastring = NULL,fast = TRUE)
#sqlTables(channel, errors = FALSE, as.is = TRUE,catalog = NULL, schema = NULL, tableName = NULL,tableType = NULL, literal = FALSE)
#sqlTypeInfo(channel, type = "all", errors = TRUE, as.is = TRUE)  --> Request information about data types in an ODBC database

