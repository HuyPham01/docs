# nginx proxy
Cấu hình upstream nginx 
```
upstream backend {
    server x.x.x.x:80;
    server x.x.x.x:80;
}
server {
    listen 80;
    server_name demo.huydp.xyz;
    access_log /var/log/nginx/example.com.access.log;
    error_log /var/log/nginx/example.com.error.log;
    location / {
      proxy_pass http://backend;
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
# load balancer glb 
<img width="587" alt="image" src="https://github.com/HuyPham01/docs/assets/96679595/56532ea6-cb82-4144-a1a5-924dd59b2d1e">  

  
Tạo instance group  
![image](https://github.com/HuyPham01/docs/assets/96679595/fa08056c-83a1-4bbe-a397-504e5db200d4)   

