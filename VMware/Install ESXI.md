# Step1 Chuận bị file IOS ESXI 6.5
Dowload page: https://customerconnect.vmware.com/downloads/#all_products   
Tạo USB boot với Rufus  
# Step2 Cài đặt
Vào Menu boot -> chọn `ESXI-6.5.0 ... install`  
![image](https://github.com/HuyPham01/docs/assets/96679595/e56c89f0-e7aa-4189-b6ab-b5a0a11fcd18)  
Chương trình bắt đầu tải bộ cài đặt ESXI 6.5 lên bộ nhớ Ram  
![image](https://github.com/HuyPham01/docs/assets/96679595/a3e05f41-c654-4720-9b1e-b9184880dd34)  

![image](https://github.com/HuyPham01/docs/assets/96679595/e55ba03b-3d4f-4706-934a-adf4dd072265)  

Chương trình cài đặt sẽ xuất hiện nội dung chào mừng bạn đến với ESXI 6.5. Ấn `Enter` để tiếp tục  

![image](https://github.com/HuyPham01/docs/assets/96679595/ce50b97f-347a-47e7-ad5b-3345693a89e0)  

Sau đó sẽ chọn ổ cứng để cài ESXI vào ổ đó. Lưu ý là sẽ xuất hiện `prompt` kêu xác nhận xoá hết data trong ổ cứng để tiến hành cài đặt. `Enter` để tiếp tục  

![image](https://github.com/HuyPham01/docs/assets/96679595/5d548b40-01c7-4fc5-b8bf-da93e49cb21f)  

Tiếp đến sẽ chọn ngôn ngữ hiện thị. Chọn ngôn ngữ tiếng `Anh` keyboard default là `US`  

![image](https://github.com/HuyPham01/docs/assets/96679595/1aeeff67-79ca-4646-9a34-4f4891280a2c)  

Tiếp theo cấu hình `password root`. `Root` là tài khoản cao nhất trong hệ thống ESXI. `Lưu ý lưu note lại khỏi quên.`  

![image](https://github.com/HuyPham01/docs/assets/96679595/207b863b-93c4-4bc5-a9eb-bbd5a7af4443)  

ESXI sẽ scan một số thành phần hardware của server.  

![image](https://github.com/HuyPham01/docs/assets/96679595/28c00c84-b70d-4020-97f9-ac74aad4f50a)  

Ổ cứng đã được tái phân vùng `f11` để cài đặt  

![image](https://github.com/HuyPham01/docs/assets/96679595/d0c23ad8-507f-4d28-9e7d-ad1192517b20)  

Quá trình cài đặt  

![image](https://github.com/HuyPham01/docs/assets/96679595/886ac197-7214-4562-b9ea-3018746d010e)  

Sau khi hoàn tất, hệ thống yêu cầu reboot nhấn `Enter`  

![image](https://github.com/HuyPham01/docs/assets/96679595/4d8c0928-eb73-49e2-9b86-5fb2778ddc22)  

Sau khi reboot giao diện thiện thị(DCUI) của ESXI 6.5  

![image](https://github.com/HuyPham01/docs/assets/96679595/29c4948f-34d7-42d3-aa91-a5ab93763520)  

Ấn `f2` để vào bên trong - gômg các chức năng cơ bản cho ESXI. Lúc này yều cầu pass của user `root`  

![image](https://github.com/HuyPham01/docs/assets/96679595/0ef066d3-de55-423e-81be-624d099f0682)   

## Config IP tĩnh
chon `configure management network`  

![image](https://github.com/HuyPham01/docs/assets/96679595/29ac1498-f92d-4998-8a99-875cce893921)  

Chọn `IPv4 config....`  

![image](https://github.com/HuyPham01/docs/assets/96679595/6d369791-876b-497f-ad8b-999c8098393f)

`Set static Ipv4...` để cấu hình ip tĩnh  

![image](https://github.com/HuyPham01/docs/assets/96679595/3c176253-b758-4d88-b990-f1d01328d28d)  

Nhấn `ESC` để thoát, thông xác nhận thay đổi cấu hình network chọn `Y` để lựu lại  

![image](https://github.com/HuyPham01/docs/assets/96679595/4a20a212-c09c-46b7-90c6-9baa9ed15f1c)  

# Truy cập ESXI bằng Web client

truy cập bằng `https://{server}`  
login băng user password `root`  
![image](https://github.com/HuyPham01/docs/assets/96679595/c3307f07-1f34-4699-9bc5-68b44efeb2be)






















