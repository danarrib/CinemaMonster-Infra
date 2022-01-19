
docker exec -it cinema_sqlserver mkdir /usr/sqlsetup

docker cp SetupSQL.sql cinema_sqlserver:/usr/sqlsetup/setup.sql

docker exec -it cinema_sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Pswd123@ -d master -i /usr/sqlsetup/setup.sql