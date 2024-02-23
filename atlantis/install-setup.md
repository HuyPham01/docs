# Install Terraform
terraform needs to be in the $PATH for Atlantis. [Download from](https://developer.hashicorp.com/terraform/downloads)
# Download Atlantis
[Download from](https://github.com/runatlantis/atlantis/releases)
```
wget https://github.com/runatlantis/atlantis/releases/download/v0.27.1/atlantis_linux_amd64.zip
ls -lrt atlantis_linux_amd64.zip
unzip atlantis_linux_amd64.zip
cp atlantis /usr/bin/
atlantis version
```
# Start Atlantis
```
HOSTNAME=YOUR_GITLAB_ENTERPRISE_HOSTNAME # ex. gitlab.runatlantis.io
atlantis server \
--atlantis-url="$URL" \
--gitlab-user="$USERNAME" \
--gitlab-token="$TOKEN" \
--gitlab-webhook-secret="$SECRET" \
--gitlab-hostname="$HOSTNAME" \
--repo-allowlist="$REPO_ALLOWLIST"
```
`$URL`: link webhook `https://atlantis.domain.xyz/events`  
# Start atlantis docker
```
version: "3"
services:
  atlantis:
    image: runatlantis/atlantis
    container_name: atlantis
    restart: always
    ports:
      - 127.0.0.1:4141:4141
    environment:
      ATLANTIS_GITLAB_TOKEN: "wasd"
      ATLANTIS_GITLAB_WEBHOOK_SECRET: "wasd"
      HCLOUD_TOKEN: "wasd"
      HETZNER_DNS_API_TOKEN: "wasd"
      TF_HTTP_ADDRESS: https://gitlab.mydomain.com/api/v4/projects/<ID>/terraform/state/project
      TF_HTTP_LOCK_ADDRESS: https://gitlab.mydomain.com/api/v4/projects/<ID>/terraform/state/project/lock
      TF_HTTP_UNLOCK_ADDRESS: https://gitlab.mydomain.com/api/v4/projects/<ID>/terraform/state/project/lock
      TF_HTTP_USERNAME: me
      TF_HTTP_PASSWORD: password
      TF_HTTP_LOCK_METHOD: POST
      TF_HTTP_UNLOCK_METHOD: DELETE
    command:
      - server
      - --atlantis-url=https://atlantis.mydomain.com
      - --gitlab-user=my-bot
      - --repo-allowlist=gitlab.mydomain.com/my-project/iac
      - --gitlab-hostname=gitlab.mydomain.com
```
## nginx proxy atlantis
```
upstream backend1 {
    server 127.0.0.1:4141;
}
server {
  listen 443 ssl http2;
  server_name atlantis.xxx.xyz;
  # SSL
  ssl_certificate /etc/letsencrypt/live/atlantis.xxx.xyz/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/atlantis.xxx.xyz/privkey.pem;
  # logging
  access_log /var/log/nginx/atlantis.access.log;
  error_log /var/log/nginx/atlantis.error.log warn;
  # reverse proxy
  location / {
    proxy_set_header Host $http_host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Ssl on;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_pass http://backend1;
  }
}
# HTTP redirect
server {
  if ($host = atlantis.xxx.xyz) {
    return 301 https://$host$request_uri;
  } # managed by Certbot
  listen 80;
  server_name atlantis.xxx.xyz;
  location / {
    return 301 https://atlantis.xxx.xyz$request_uri;
  }
}
```
