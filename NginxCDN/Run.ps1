docker run -p 3080:80 -p 3443:443 --name cinema_nginx_cdn `
-v "C:\DevData\git\CinemaMonster-Infra\NginxCDN\public\:/usr/share/nginx/html:ro" `
-v "C:\DevData\git\CinemaMonster-Infra\NginxCDN\conf\:/etc/nginx/conf.d:ro" `
-v "C:\DevData\git\CinemaMonster-Infra\NginxCDN\certs\:/etc/nginx/ssl:ro" `
--net CinemaNetwork -d nginx
