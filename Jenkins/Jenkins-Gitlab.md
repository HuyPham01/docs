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





