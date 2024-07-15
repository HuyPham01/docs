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
