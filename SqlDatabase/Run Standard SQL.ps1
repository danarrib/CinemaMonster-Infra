docker volume create mssqlsystem
docker volume create mssqluser
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Pswd123@" -e "MSSQL_PID=Express" --volume mssqlsystem:/var/opt/mssql --volume mssqluser:/var/opt/sqlserver --name cinema_sqlserver -p 1433:1433 --net CinemaNetwork -d mcr.microsoft.com/mssql/server

