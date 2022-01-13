FROM mcr.microsoft.com/mssql/server AS base

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Pswd123@
ENV MSSQL_PID=Express

COPY . .
COPY ["Db/Scripts/*", "Db/Scripts/"]
VOLUME ./Db:/var/opt/mssql/data

EXPOSE 1433

HEALTHCHECK --interval=10s --timeout=5s --start-period=10s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S . -U sa -P Pswd123@ -i Db/Scripts/SetupDb.sql || exit 1