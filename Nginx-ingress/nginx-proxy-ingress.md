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

  
`Step1` Tạo instance group  
![image](https://github.com/HuyPham01/docs/assets/96679595/fa08056c-83a1-4bbe-a397-504e5db200d4)   
Chọn `create instance group`  
<img width="770" alt="image" src="https://github.com/HuyPham01/docs/assets/96679595/81e93300-4e2b-427d-8d87-1d97daad8364">  
  
Trong `instance group` có 3 option:  
- Cả 2 option managed instance group (stateful) và (stateless) đề giống nhau: quản lý tự động bởi Google, VM được tạo từ Instance Template,  
- Stateless: Các VM trong nhóm không lưu trữ bất kỳ dữ liệu hoặc trạng thái nào trên chính chúng. Thay vào đó, chúng dựa vào các dịch vụ khác như Cloud Storage hoặc Cloud SQL để lưu trữ dữ liệu. Điều này giúp cho việc thêm, xóa hoặc thay thế các VM trong nhóm dễ dàng hơn, vì không cần phải lo lắng về việc mất dữ liệu.  
- Stateful: Các VM trong nhóm lưu trữ dữ liệu và trạng thái trên chính chúng. Điều này phù hợp hơn với các ứng dụng có trạng thái như database. Tuy nhiên, việc thêm, xóa hoặc thay thế các VM trong nhóm sẽ phức tạp hơn, vì cần phải đảm bảo rằng dữ liệu và trạng thái được bảo toàn.
- New unmanaged instance group: VM không được quản lý bở Template.  
Tôi đang sử dụng option `New unmanaged instance group` 
<img width="364" alt="image" src="https://github.com/HuyPham01/docs/assets/96679595/5f706deb-bb4d-4abd-a2c3-c4e48b387b0a">  

