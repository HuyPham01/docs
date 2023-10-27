# Step 1 
download file vcenter 6.7 iso: https://customerconnect.vmware.com/downloads/#all_products  
mount file iso vào một máy windowns và tìm đến file cài đặt ở: `vcsa-ui-installer\win32\installer.exe`  

![image](https://github.com/HuyPham01/docs/assets/96679595/a693ab5f-72ed-4d0f-95cc-023194f82d74)  
# Step 2 
Sau khi khỏi động file cài đặt giao diện cài đạt có 4 sự lựa chọn  
- `Install`: cài đặt

- `Upgreade`: nâng cấp VCSA đang có trong hệ thống lên phiên bản 6.7  

- `Migrate`: thực hiện migrate Windows vCenter Server sang vCenter Server Appliance.  

- `Restore`: khôi phục VCSA từ dữ liệu đã sao lưu.

![image](https://github.com/HuyPham01/docs/assets/96679595/1c8becb4-9563-4dac-92e8-355e62c8ed9c)  
# Step 3
Màn hình chỉ dẫn cài đặt sẽ giải thích về quá trình gồm 2 giai đoạn để triển khai `VCSA`. Ở giai đoạn đầu tiên chúng ta sẽ triển khai cài đặt phần mềm `VCSA 6.5`. Sau đó đến giai đoạn kế, chúng ta sẽ cấu hình cho `VCSA 6.7`.  
![image](https://github.com/HuyPham01/docs/assets/96679595/f85a811b-299d-46f9-8f9f-498a0ad954ac)  

# Step 4
Chấp nhận các quy định  
![image](https://github.com/HuyPham01/docs/assets/96679595/aec62593-8688-44ea-81fd-cef8f0946271)  
# Step 5
Chọn hình thức triển khai `VCSA 6.7` ở chọn hình thức đầu tiên `vCenter Server with Embedded Platform Services Controller`. Hình thức này giúp gom 2 dịch vụ chương trình của `VCSA 6.5` chung lại một chỗ không tách ra các dịch vụ riêng  như lựa chọn số 2.  
![image](https://github.com/HuyPham01/docs/assets/96679595/30daa014-04d5-4f80-b469-0895e67e84ce)  
# Step 6 
Cần khai báo thông tin về máy chủ `ESXi`  mà `VCSA 6.5` sẽ được cài đặt trên đó. Hãy khai báo thông tin địa chỉ IP (hoặc tên miền), port, user, pass để chương trình cài đặt có thể đăng nhập vào vSphere ESXi  

![image](https://github.com/HuyPham01/docs/assets/96679595/055c12d2-b434-4269-ae18-268236aea20d)  

# Step 7

Khai báo thông tin cơ bản về máy chủ ảo như `tên VM`, `mật khẩu root` cho máy chủ ảo VM `VCSA`  
Note lại khỏi quyên `user`, `pass`  

![image](https://github.com/HuyPham01/docs/assets/96679595/31480b9d-8a7a-4fc6-b5dd-db8f699f62df)  

# Step 8
Cần lựa chọn kích cỡ tài nguyên mà `VCSA 6.5`  cần có để quản lý được số lượng như: máy chủ host ESXi và số lượng máy chủ ảo VM.   
Ở đây chọn `Deployment Size:Small` do có nhiều hơn 10 host `ESXI` cần quản lý.  
![image](https://github.com/HuyPham01/docs/assets/96679595/2382590f-0d69-4bf6-9f2c-cd7d1a282a3b)  

# Step 9
Chọn phân vùng lưu trữ dữ liệu của máy chủ `VCSA 6.5`
![image](https://github.com/HuyPham01/docs/assets/96679595/95ac22f6-7ff3-4e74-a1b0-7f5f69fd273b)  

# Step 10 
Config network   
Trong phần network chọn card mạng mà ESXI đã có sẵn  
Hiện tại đang để `DHCP` có thể để tĩnh sau khi cài đặt xong  
![image](https://github.com/HuyPham01/docs/assets/96679595/caf3befb-581e-4bdd-8fe0-e3f3394da6c4)  

# Step 11
Tông kết kiểm tra lại các thông tin trước khi tiến hành cài đặt  
![image](https://github.com/HuyPham01/docs/assets/96679595/c0451cc2-052d-4936-a97f-97056474a316)  

Quá trình cài đặt vCenter server 6.5 ở giai đoạn 1 sẽ đắt đầu và sẽ đợi 1 khoảng thời gian đến khi nó hoàn thành  
![image](https://github.com/HuyPham01/docs/assets/96679595/760521d6-45bc-40b0-89ec-ab140c4fbade)  

Thông báo giai đoạn 1 đã hoàn tất  
![image](https://github.com/HuyPham01/docs/assets/96679595/347e4b4b-221b-4fe2-99f6-617255e843a7)  

# Giai đoạn 2

# Step 12
Tiếp tục cấu hình phần mền dịch vụ `VM VCSA 6.5` đã được triển khai cài đăt lên VM trên ESXI. Chọn `Next` để bắt đầu giao đoạn 2.    
![image](https://github.com/HuyPham01/docs/assets/96679595/e2398790-9b9e-44e1-bfb1-51fc9838a3b6)  

# Step 13
Cấu hình `NTP` đồng bộ thời gian. Nếu không có thì bỏ qua  
![image](https://github.com/HuyPham01/docs/assets/96679595/24c1ea3c-8c3e-4a87-aa89-b31c2c8518d4)  

# Step 14
Nhập thông tin SSO để quản lý đăng nhập vào `vCenter Web Client` để quản lý hạ tậng máy chủ ảo ESXI.  
User name thường được thể hiện: `administrator@{doamin}` domain ở đây là `vcenter.local`  
![image](https://github.com/HuyPham01/docs/assets/96679595/3170ad91-4380-4f01-a565-f145c98b4932)  

# Step 15
đây là thông báo tham gia chương trình trải nghiệm khách hàng hay không? Nếu không tham gia thì không stick vào và 'Next`.  
![image](https://github.com/HuyPham01/docs/assets/96679595/08a4f22d-62b4-4aae-bbf1-cc2189f9d4aa)  

# Step 16
Kiểm tra config 
![image](https://github.com/HuyPham01/docs/assets/96679595/662faa75-83b3-44b2-b966-6e3324110119)  

Quá trình cấu hình sẽ bắt đầu.  
![image](https://github.com/HuyPham01/docs/assets/96679595/08f2733a-5d59-4ab0-95dc-f8123fdfe4ab)  


