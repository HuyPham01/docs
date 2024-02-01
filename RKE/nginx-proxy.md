# install rancher docker
```
docker run -d --restart=unless-stopped \
--name=rancher-server -p 5080:80 \
--privileged rancher/rancher:v2.8.0-rc3
```
# nginx proxy
file config
```
upstream rancher {
    server localhost:5080;
}

map $http_upgrade $connection_upgrade {
    default Upgrade;
    ''      close;
}

server {
    listen 443 ssl http2;
    server_name rancher.xxx.xxx;
    ssl_certificate /etc/letsencrypt/live/rancher.xxx.xxx/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/rancher.xxx.xxx/privkey.pem;

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Port $server_port;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://rancher;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        # This allows the ability for the execute shell window to remain open for up to 15 minutes. Without this parameter, the default is 1 minute and will automatically close.
        proxy_read_timeout 900s;
    }
}

server {
    listen 80;
    server_name rancher.xxx.xxx;
    return 301 https://$server_name$request_uri;
}
```
