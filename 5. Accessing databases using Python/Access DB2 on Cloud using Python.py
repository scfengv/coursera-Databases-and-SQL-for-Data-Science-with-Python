import ibm_db

# Identify the database connection credentials #

# Require
# Driver Name
# Database name
# Host DNS name or IP address
# Host port
# Connection protocol
# User ID
# User Password
dsn_driver = "{IBM DB2 ODBC DRIVER}"
dsn_database = "BLUDB"            
dsn_hostname = "ba99a9e6-d59e-4883-8fc0-d6a8c9f7a08f.c1ogj3sd0tgtu0lqde00.databases.appdomain.cloud"          
dsn_port = "31321"                  
dsn_protocol = "TCPIP"           
dsn_uid = "smt18684"                
dsn_pwd = "Lsb8ouTylZNDetDW"        
dsn_security = "SSL" 


# ONIF the database is already created

# dropQuery = "drop table INSTRUCTOR"
# dropStmt = ibm_db.exec_immediate(conn, dropQuery)


# Create the database connection #

# Ibm_db API uses the IBM Data Server Driver for ODBC and CLI APIs to connect to IBM DB2 and Informix
dsn = (
    "DRIVER={0};"
    "DATABASE={1};"
    "HOSTNAME={2};"
    "PORT={3};"
    "PROTOCOL={4};"
    "UID={5};"
    "PWD={6};"
    "SECURITY={7};").format(dsn_driver, dsn_database, dsn_hostname, dsn_port, dsn_protocol, dsn_uid, dsn_pwd,dsn_security)

try:
    conn = ibm_db.connect(dsn, "", "")
    print ("Connected to database: ", dsn_database, "as user: ", dsn_uid, "on host: ", dsn_hostname)

except:
    print ("Unable to connect: ", ibm_db.conn_errormsg() )
# Now you have already connected to the database above


# Create a table in the database #

# Construct the Create Table DDL statement
createQuery = "CREATE TABLE INSTRUCTOR ( ID INTEGER PRIMARY KEY NOT NULL, FNAME VARCHAR(20), LNAME VARCHAR(20), CITY VARCHAR(20), CCODE CHAR(2))"
# ibm_db.exec_immediate (connection, SQL Statement) is used to make connection with Table
# SQL Statement is a string ("SQL STATEMENT") which contains the action you want to do to the Table
createStmt = ibm_db.exec_immediate ( conn, createQuery )

# Insert data into the table #

# Construct the query
insertQuery = "INSERT INTO INSTRUCTOR ( ID, FNAME, LNAME, CITY, CCODE ) VALUES (1,'Rav', 'Ahuja', 'TORONTO', 'CA'), (2, 'Raul', 'Chong', 'Markham', 'CA'), (3, 'Hima', 'Vasudevan','Chicago','US');"
insertStmt = ibm_db.exec_immediate ( conn, insertQuery )

# Query data in the table #

# Construct the query that retrieves all rows from the INSTRUCTOR table
selectQuery = "select * from INSTRUCTOR"
selectStmt = ibm_db.exec_immediate ( conn, selectQuery )

# Fetch (take the info) the Dictionary #

# https://www.ibm.com/docs/en/ias?topic=SSHRBY/com.ibm.swg.im.dbclient.python.doc/doc/t0054388.htm
while ibm_db.fetch_row ( selectStmt ) != False:
    print ( " ID: ",  ibm_db.result ( selectStmt, 0 ), " FNAME:",  ibm_db.result ( selectStmt, " FNAME " ) )

# Update statement (change in SQL statement) #

updateQuery = " UPDATE INSTRUCTOR SET CITY = ' MOOSETOWN ' WHERE FNAME = ' Rav ' "
updateStmt = ibm_db.exec_immediate ( conn, updateQuery )


# Retrieve data into Pandas #

# Pandas is a Python library make data analysis fast and ez in Python
import pandas
import ibm_db_dbi

# connection for pandas
pconn = ibm_db_dbi.Connection ( conn )

# query statement to retrieve all rows in INSTRUCTOR table
selectQuery = "select * from INSTRUCTOR"

# retrieve the query results into a pandas dataframe
pdf = pandas.read_sql ( selectQuery, pconn )

# print the entire data frame
pdf

# print just the LNAME for first row in the pandas data frame
pdf.LNAME[0]

# use the shape method to see how many rows and columns are in the dataframe
pdf.shape

### LAST BUT NOT LEAST ###
# Close the Connection #
ibm_db.close ( conn )