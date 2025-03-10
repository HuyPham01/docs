# Làm thế nào để tránh ổ đĩa bị đầy khi xài Docker?
## Xóa image với tag none
Một trong những thứ chiếm dung lượng ổ đĩa nhiều nhất là Docker Image, nhưng thứ khiến ổ đĩa bị đầy lại không phải là những image ta dùng để chạy chương trình mà nguyên nhân chính đến từ những image với tag `<none>`.  
  
Gõ câu lệnh `docker images` để kiểm tra.
```
docker images
```
```
REPOSITORY                             TAG       IMAGE ID       CREATED         SIZE
postgres                               <none>    5861c038d674   14 months ago   371MB
k8s.gcr.io/ingress-nginx/controller    <none>    bf621a764db5   17 months ago   278MB
k8s.gcr.io/ingress-nginx/controller    <none>    81d7cdfa4169   2 years ago     280MB
```
Các image tag `<none>` này là các image rất cũ được sinh ra trong quá trình ta chạy CI/CD để xây dựng image từ Dockerfile hoặc trong quá trình ta kéo image từ trên registry xuống. Ta có thể xóa image tag `<none>` để giảm dung lượng của ổ đĩa.  

Với Docker phiên bản nhỏ hơn 1.13, chạy câu lệnh sau để liệt kê toàn bộ image tag `<none>`:  

```
docker images -f "dangling=true"
```
Thêm `-q` vào để chỉ lấy `IMAGE ID`:  
```
docker images -f "dangling=true" -q
```
Thực thi câu lệnh xóa:  
```
docker rmi $(docker images -f "dangling=true" -q)
```
Với Docker phiên bản 1.13+:
```
docker image prune
```
Ta nên cấu hình crontab để chạy 1 ngày 1 lần với câu lệnh trên.
```
cat <<EOF >> /etc/cron.daily/clear-tag-none
#!/bin/sh

docker rmi $(docker images -f "dangling=true" -q)
EOF
```
```
chmod +x /etc/cron.daily/clear-tag-none
```
Tùy vào hệ điều hành thì cấu hình crontab cho phù hợp.  

## Xóa tệp tin json logs của Docker
Thứ chiếm dung lượng ổ đĩa tiếp theo là Docker Json Logs, mặc định khi cài Docker thì toàn bộ logs của container sẽ được Docker lưu ở thư mục `/var/lib/docker/containers/*` ở dạng json, nếu ta không thường xuyên xóa logs ở thư mục này thì nó sẽ lên tới vài chục hoặc vài trăm GB.  

Để xóa logs ở thư mục này ta có vài cách sau:  

- Cấu hình crontab  
- Dùng logrotate  
- Giới hạn dung lượng logs của container  
## Xóa thủ công với crontab
Nếu logs của container không quan trọng thì bạn dùng cách sau để xóa logs.

Câu lệnh để xóa toàn bộ logs trong tệp tin:
```
cat /dev/null > /var/lib/docker/containers/*/*-json.log
```
Cấu hình crontab:
```
cat <<EOF >> /etc/cron.daily/clear-container-logs
#!/bin/sh

cat /dev/null > /var/lib/docker/containers/*/*-json.log
EOF
```
```
chmod +x /etc/cron.daily/clear-container-logs
```
## Tự động với logrotate
Nếu bạn muốn giữ lại logs thì có thể dùng `logrotate` để tự động giảm dung lượng logs của Docker.  

Hầu hết các Linux Distro đều cài sẵn `logrotate`, cấu hình logrotate cho tệp tin logs của Docker rất đơn giản, ta tạo tệp tin `logrotate-container` ở thư mục `/etc/logrotate.d` và dán cấu hình ở dưới vào:
```
/var/lib/docker/containers/*/*.log {
  rotate 7
  daily
  compress
  missingok
  delaycompress
  copytruncate
}
```
Chạy thử:
```
logrotate -fv /etc/logrotate.d/logrotate-container
```
Măc định logrotate có sẵn crontab nằm ở thư mục `/etc/cron.daily` để chạy logrotate hằng ngày nên ta không cần phải cấu hình crontab thêm.

## Giới hạn dung lượng logs của container
Từ phiên bản 1.8 trở đi thì Docker có sẵn chức năng logrotate cho json logs. Khi chạy container ta thêm vào thuộc tính `--log-opt` vào để giới hạn dung lượng logs của container.
```
docker run --log-driver json-file --log-opt max-size=10m nginx
```
Nếu ta cần cấu hình cho toàn bộ container thì thêm cấu hình sau vào `daemon.json`, nằm ở thư mục `/etc/docker/` trên Linux.
```
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
```
