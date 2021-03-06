docker run -p 8080:8080 -p 8443:8443 `
-e "KEYCLOAK_USER=admin" `
-e "KEYCLOAK_PASSWORD=admin" `
-e "DB_VENDOR=mssql" `
-e "DB_USER=sa" `
-e "DB_PASSWORD=Pswd123@" `
-e "DB_ADDR=cinema_sqlserver" `
-e "DB_DATABASE=Keycloak" `
-d `
--net CinemaNetwork `
--name cinema_keycloak `
quay.io/keycloak/keycloak:16.1.0