# Install mkcert using Chocolatey
choco install mkcert

# Install local CA (Certificate Authority)
mkcert -install

# Generate Certificate files for local domain
mkcert -key-file ssl.key -cert-file ssl.crt cinema.local

del C:\DevData\git\CinemaMonster-Infra\NginxCDN\certs\ssl.*

mv ssl.* C:\DevData\git\CinemaMonster-Infra\NginxCDN\certs\