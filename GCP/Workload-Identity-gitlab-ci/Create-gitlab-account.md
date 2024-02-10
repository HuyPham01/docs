# Setup Workload Identity Federation
## Step 1: Create a Workload Identity Pool.
```
gcloud iam workload-identity-pools create gitlab-demo-wip \
  --location="global" \
  --description="Gitlab demo workload Identity pool" \
  --display-name="gitlab-demo-wip"
  --project=$GCP_PROJECT_ID
```
![image](https://github.com/HuyPham01/docs/assets/96679595/b6aa5de3-005c-435d-8b33-08c32d5f5a34)  
workload identity pool  
![image](https://github.com/HuyPham01/docs/assets/96679595/edd8fdf1-8f9d-4a1d-a7df-b27c166c1040)  
workload identity pool configuration  
## Step 2: Thêm nhà cung cấp nhóm nhận dạng khối lượng công việc cho GitLab và sử dụng các điều kiện Thuộc tính để hạn chế danh tính nào có thể xác thực bằng cách sử dụng workload identity pool.
Cấu hình attribute mapping là một phần quan trọng trong việc thiết lập liên kết nhận dạng khối lượng công việc. Nó cho phép   ánh xạ các thuộc tính từ thông tin xác thực do nhà cung cấp danh tính bên ngoài cấp tới các thuộc tính của Google Cloud, chẳng hạn như `subject` và `email`. Một số nhà cung cấp danh tính coi các thuộc tính này là xác nhận quyền sở hữu.  
Đối với các nhà cung cấp OIDC (OpenID Connect) như Gitlab, cung cấp ánh xạ. Để xây dựng ánh xạ, hãy tham khảo tài liệu của nhà cung cấp để biết danh sách các thuộc tính trên thông tin xác thực của họ. Đối với gitlab, hãy tham khảo tải trọng Mã thông báo ID để biết các xác nhận quyền sở hữu có trong mỗi mã thông báo ID gitlab.
