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
