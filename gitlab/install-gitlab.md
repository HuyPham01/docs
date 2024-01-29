# Lệnh khởi tạo gitlab container
```
docker run -dit \
  --publish 2222:22 --publish 8000:80 \
  --name gitlab13 \
  --privileged \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  gitlab/gitlab-ce:13.12.8-ce.0
```
# Cài đặt gitlab + runner với compose file 
```
version: '3.7'
services:
  web:
    image: 'gitlab/gitlab-ce:latest'
    restart: always
    hostname: 'localhost'
    container_name: gitlab-ce
    shm_size: "256m"
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://localhost'
    ports:
      - '8080:80'
      - '8443:443'
      - '8022:22'
    volumes:
      - '$GITLAB_HOME/config:/etc/gitlab'
      - '$GITLAB_HOME/logs:/var/log/gitlab'
      - '$GITLAB_HOME/data:/var/opt/gitlab'
    networks:
      - gitlab
  gitlab-runner:
    image: gitlab/gitlab-runner:alpine
    container_name: gitlab-runner    
    restart: always
    depends_on:
      - web
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - '$GITLAB_HOME/gitlab-runner:/etc/gitlab-runner'
    networks:
      - gitlab

networks:
  gitlab:
    name: gitlab-network
```
file `.env`  
```
GITLAB_HOME=/srv/gitlab
```
create folder data gitlab  
```
mkdir -p ~/srv/gitlab
```
Hiển thị password default `root` gitlab  
```
docker exec -it gitlab-ce grep 'Password:' /etc/gitlab/initial_root_password
```
Đăng ký gitlab runner với gitlab server   
```
docker exec -it gitlab-runner gitlab-runner register
```
# config nginx proxy gitlab
```
upstream backend {
    server 127.0.0.1:8080;
}
server {
  listen 443 ssl http2;
  server_name gitlab.xxx.xxx;
  # SSL
  ssl_certificate /etc/letsencrypt/live/gitlab.xxx.xxx/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/gitlab.xxx.xxx/privkey.pem;
  # logging
  access_log /var/log/nginx/git.access.log;
  error_log /var/log/nginx/git.error.log warn;
  # reverse proxy
  location / {
    client_max_body_size 2G;
    gzip off;
    ## https://github.com/gitlabhq/gitlabhq/issues/694
    ## Some requests take more than 30 seconds.
    proxy_read_timeout 300;
    proxy_connect_timeout 300;
    proxy_redirect off;
    proxy_http_version 1.1;
    proxy_set_header Host $http_host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Ssl on;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_pass http://backend;
  }
}
# HTTP redirect
server {
  if ($host = gitlab.xxx.xxx) {
    return 301 https://$host$request_uri;
  } # managed by Certbot
  listen 80;
  server_name gitlab.xxx.xxx;
  location / {
    return 301 https://gitlab.xxx.xxx$request_uri;
  }
}
```
# config file gitlab.rb

```
# ---

## GitLab URL
##! URL on which GitLab will be reachable.
##! For more details on configuring external_url see:
##! https://docs.gitlab.com/omnibus/settings/configuration.html#configuring-the-external-url-for-gitlab
external_url 'https://gitlab.your-domain.com'

##! **Override only if you use a reverse proxy**
##! Docs: https://docs.gitlab.com/omnibus/settings/nginx.html#setting-the-nginx-listen-port
nginx['listen_port'] = 80

##! **Override only if your reverse proxy internally communicates over HTTP**
##! Docs: https://docs.gitlab.com/omnibus/settings/nginx.html#supporting-proxied-ssl
nginx['listen_https'] = false

# nginx['custom_gitlab_server_config'] = "location ^~ /foo-namespace/bar-project/raw/ {\n deny all;\n}\n"
# nginx['custom_nginx_config'] = "include /etc/nginx/conf.d/example.conf;"
# nginx['proxy_read_timeout'] = 3600
# nginx['proxy_connect_timeout'] = 300
nginx['proxy_set_headers'] = {
 "Host" => "$http_host_with_default",
 #"X-Real-IP" => "$remote_addr",
 "X-Forwarded-For" => "$proxy_add_x_forwarded_for",
 "X-Forwarded-Proto" => "https",
 "X-Forwarded-Ssl" => "on",
 #"Upgrade" => "$http_upgrade",
 #"Connection" => "$connection_upgrade"
}

### GitLab Shell settings for GitLab
# map port ssh gitlab
gitlab_rails['gitlab_shell_ssh_port'] = 8022
```
