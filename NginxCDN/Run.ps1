docker run -p 3080:80 -p 3443:443 --name cinema_nginx_cdn `
-v "D:\Document\DevData\git\Cinema Monster\Nginx CDN\public\:/usr/share/nginx/html:ro" `
-v "D:\Document\DevData\git\Cinema Monster\Nginx CDN\conf\:/etc/nginx/conf.d:ro" `
-v "D:\Document\DevData\git\Cinema Monster\Nginx CDN\certs\:/etc/nginx/ssl:ro" `
-d nginx
