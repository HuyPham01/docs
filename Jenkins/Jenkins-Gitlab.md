# Step1 Tạo mới User Jenkins trên Gitlab
### Bước 1: Chọn Setting ‘Admin’
![image](https://github.com/user-attachments/assets/c41b8f8f-db4b-4480-a9c6-66983047906d)  
### Bước 2: Chọn New user
![image](https://github.com/user-attachments/assets/c084beab-170d-4252-a0d0-ee0e9d7b9007)  
### Bước 3: Nhập thông tin Account
Name: `Jenkins User`  
Username: `jenkins`  
Email: `jenkins@demo.com`  
![image](https://github.com/user-attachments/assets/bb62303f-cc4d-4ded-b999-759e84775b74)  
### Bước 4: Tại mục Access
![image](https://github.com/user-attachments/assets/28fdcedb-027c-4bb4-ba40-3047fc01fa00)  
Chọn `Create User`  
### Bước 5: Chọn User
![image](https://github.com/user-attachments/assets/499c51d7-d0c9-4661-ab33-b0e1c579a759)  
### Bước 6: Chọn Edit
![image](https://github.com/user-attachments/assets/7184b80b-215a-4540-8e62-2a81f6258ef4)  
### Bước 7: Đặt thông tin Password cho User Jenkins
Nhập 2 giá trị, `Password` và `Password confirmation`  

![image](https://github.com/user-attachments/assets/4e755989-1f82-44fb-976e-7d5ff81565d7)  
Chọn `Save changes`  
# Tạo Token User Jenkins trên Gitlab
Đăng nhập tài khoản `Jenkins` trên `gitlab`  
Đổi mật khẩu lần đầu  
Đăng nhập với mật khẩu mới  
### Step1 Mở cấu hình User
Chọn `Avatar user`  
Chọn `Settings`  

![image](https://github.com/user-attachments/assets/e30c8635-9081-4ccc-9bdd-6266ad13bc66)  
### Bước 2: Chọn Access Tokens

![image](https://github.com/user-attachments/assets/6004be69-c590-405a-a3dd-ff7815ba9026)  
Chọn `Add new token`
### Bước 3: Nhập thông tin token
Tại Name: `jenkins`  
Scopes, chọn `api`  
Disable `Expiration date`  
Chọn `Create personal access token`  

![image](https://github.com/user-attachments/assets/5db4428b-c183-443a-a197-134557044fa3)  
### Bước 4: Chọn ‘Copy personal access token‘

![image](https://github.com/user-attachments/assets/9add517a-9fa9-4144-b4db-e416654c1bc1)  
Lưu ý, copy token tới 1 nơi lưu trữ tạm vì sẽ cần sử dụng nó, token là `glpat-vzf9Dzs34r_xAF_xVNh9`  
# User Gitlab trên Jenkins
### Bước 1: Chọn Manage Jenkins

![image](https://github.com/user-attachments/assets/e8777cc9-46e9-4fb5-a856-5f66d7d1ec1a)
  
### Bước 2: Chọn Manage Users

![image](https://github.com/user-attachments/assets/4b20c978-2c8b-4e73-b5c8-ceca04fa4069)  
### Bước 3: Chọn Create User

![image](https://github.com/user-attachments/assets/6f053721-c23e-4f87-b256-cf89103f5a00)  
### Bước 4: Nhập thông User và khởi tạo
Nhập `User: gitlab`  
Nhập `Password: XXXX`  
Nhập `Confirm password: XXXX`  
Nhập `Full name: Gitlab User`  
Nhập `E-mail address: gitlab-user@example.com`  
Chọn `Create User` sau khi nhập liệu xong  

![image](https://github.com/user-attachments/assets/5f25cab3-e4f4-4aaf-b438-3644a06c78ef)  

![image](https://github.com/user-attachments/assets/493c255f-e7ff-49f6-8d3c-bcc1c7da214b)  

# Thiết lập User Gitlab trên Jenkins
### Bước 1: Đăng nhập tài khoản gitlab vừa tạo
### Bước 2: Chọn Gitlab User => Configure

![image](https://github.com/user-attachments/assets/d6022db8-679d-4263-975e-dde18e9b9ae6)  

### Bước 3: Chọn Add new Token

![image](https://github.com/user-attachments/assets/5976ee63-6c42-479f-8424-bdcd4ae51833)  

### Bước 4: Nhập tên token > Chọn Generate

![image](https://github.com/user-attachments/assets/b48798bd-56b5-495a-ac92-269b5c3ef98d)  

![image](https://github.com/user-attachments/assets/ed4e1262-9d04-4df3-8b0a-31cb28f20440)  
Lưu ý, copy token tới 1 nơi lưu trữ tạm vì sẽ cần sử dụng nó, token là `11afeaa471ab8502aa350a1eecf259c49a`  
Chọn `Save` để cập nhật thông tin  
# Cài đặt Plugin
### Bước 1: Chọn Manage Jenkins
### Bước 2: Chọn Manage Plugins
### Bước 3: Cài đặt Plugin Gitlab
Chọn `Available`  
Nhập `gitlab` và ô Filter  
Chọn `GitLab`  
Chọn `Download now and install after restart`  
Pulugin: `docker-workflow`, `Blue Ocean`, `SSH Agent Plugin`,....  
# Cấu hình Credential
### Bước 1: Chọn Manage Jenkins
### Bước 2: Chọn Configure System
### Bước 3: Cấu hình Gitlab Plugins
Nhập cấu hình Gitlab  
Giá trị `Connection name: My Gitlab Connection`  
Giá trị `Gitlab host URL: http://10.10.10.85`, lưu ý đây chính là đường dẫn tới địa chỉ của Gitlab  
Chọn `Add`  
Chọn `Jenkins`  
### Bước 4: Khái báo Credentials Gitlab mới
Tại Kind: Chọn `GitLab API token`  
Nhập các giá trị:  
API token: `glpat-vzf9Dzs34r_xAF_xVNh9`, lưu ý giá trị này có được từ bước sinh API Token Gitlab  
ID: `gitlab-token`  
Description: `GitLab API Token`  
Chọn Add sau khi nhập thông tin xong  
![image](https://github.com/user-attachments/assets/854c1cf6-d642-4a6c-9d43-a1d0bd8698be)   
Test Connection  
![image](https://github.com/user-attachments/assets/17a6f5f3-103c-4720-83e5-227794dbcb5e)  
`SAVE` lưu cấu hình.
#  Tạo Pipe
### Bước 1: Chọn New item
### Bước 2: Nhập thông tin khởi tạo Pipeline
Nhập `Enter an item name: django-demo`  
Chọn loại `Pipeline`  
Chọn `Ok`  
### Bước 3: Cấu hình mục General
Cấu hình `Discard old builds`  
  
Tính năng chỉ định số bản build sẽ giữ lại, trong bài cấu hình giữ 5 bản gần nhất  
Chọn `Discard old builds`  
Nhập `Max # of builds to keep: 5`  
![image](https://github.com/user-attachments/assets/6b3d708e-d07b-4a2a-8bb6-39f393c4269b)  
Cấu hình `GitLab Connection`  
- Bảo đảm có kết nối My Gitlab Connection  
![image](https://github.com/user-attachments/assets/403e3012-a74d-476e-8c04-ea7a23a8d54e)
### Bước 4: Cấu hình Build Triggers
Chọn giá trị `Build when a change is pushed to Gitlab. GitLab webhook URL ...`  
### Bước 5: Cấu hình mục Pipeline
Khai báo cấu hình:  
  
- Tại `Definition`, chọn `Pipeline script from SCM`  
- `SCM` chọn `Git`  
- Tại `Repositories` > `Repository URL` nhập `http://10.10.10.85/root/django-demo.git`.  
- Tại `Credentials`, chọn `Add > Jenkins`  
![image](https://github.com/user-attachments/assets/f30b19d7-b798-400f-a656-d77574321dd7)  
Tại `Jenkins Creadentials Provider: Jenkins`  
   
Tại Kind chọn `Username with password`  
Nhận thông tin User  
Ở đây sẽ sử dụng tài khoản `jenkins` của Gitlab, đây là tài khoản có quyền access các thư mục code  
`ID: gitlab-user-ci`  
`Description: Used to access repositories jenkins admin`  
Chọn `Add`  
![image](https://github.com/user-attachments/assets/4eda3add-0e29-4f97-851c-71ffe21a9a01)  
Tại Credentials  
  
chọn `jenkins/**** (Used to access repositories)`  
Nếu cấu hình thành công, cảnh báo màu đỏ sẽ biến mất  
`save` để lưu lại  
# Cấu hình Webhook Gitlab

### Bước 1: Cho phép Gitlab có thể gửi Hook ra ngoài mạng
Chọn Admin Area  
Chọn 1. `Settings` > `2. Network`  
Tại mục Outbound requests  
  
Chọn `Allow requests to the local network ..`  
`Save Changes`  

### Bước 2: Cấu hình Web hook cho repo
Chọn repo  
Chọn `1. Settings` > `2. Webhooks`  
Lưu ý:  

URL Webhook sẽ có dạng `http://<gitlab-user-in-jenkins>:<token>@<host>:<port>/project/<project-name>`  
Giá trị Token có được từ bước tạo tài khoản gitlab trên Jenkins `11afeaa471ab8502aa350a1eecf259c49a`  
Tại 1, nhập URL Webhook theo format  
Tại 2 và 3, chọn `Push events` và `Merge request events`  

example:  
```
http://gitlab:11afeaa471ab8502aa350a1eecf259c49a@172.19.81.229:8080/project/django-demo
```



