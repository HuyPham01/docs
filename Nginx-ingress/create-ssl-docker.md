# Tạo Folder cho letsencrypt
```bash
sudo mkdir /etc/letsencrypt
sudo mkdir /var/lib/letsencrypt
```
# Lấy token cloudflare
```bash
vi /etc/letsencrypt/cloudflareapi.cfg
```
```bash
dns_cloudflare_email = your_cloudflare_login 
dns_cloudflare_api_key = your_cloudflare_api_key 
```
`dns_cloudflare_api_key` = API global key
### chạy docker để cấp tạo certificate cho subdomain demo.huydp.online
```bash
docker run -it --rm --name certbot \
   -v "/etc/letsencrypt:/etc/letsencrypt" \
   -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
   certbot/dns-cloudflare \
   certonly --dns-cloudflare \
   --dns-cloudflare-credentials /etc/letsencrypt/cloudflareapi.cfg -d demo.huydp.online
```
Khi chạy sẽ hỏi phần thông tin nhập email và chọn Y các câu hỏi như các bước bạn tạo certificate với Letsencrypt.  

Tất các các file cert sẽ lưu tại  /etc/letsencrypt/live/$domain  
