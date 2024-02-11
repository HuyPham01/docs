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
Điều kiện thuộc tính bên dưới chỉ giới hạn danh tính từ không gian tên GitLab cá nhân của tôi.  
```
gcloud iam workload-identity-pools providers create-oidc gitlab-identity-provider --location="global" \
 --workload-identity-pool="gitlab-demo-wip" \
 --issuer-uri="https://gitlab.com" \
 --allowed-audiences=https://gitlab.com \
 --attribute-mapping="google.subject=assertion.sub,attribute.aud=assertion.aud,attribute.project_path=assertion.project_path,attribute.project_id=assertion.project_id,attribute.namespace_id=assertion.namespace_id,attribute.namespace_path=assertion.namespace_path,attribute.user_email=assertion.user_email,attribute.ref=assertion.ref,attribute.ref_type=assertion.ref_type" \
 --attribute-condition="assertion.namespace_path.startsWith(\"$GITLAB_NAMESPACE_PATH\")" \
 --project=$GCP_PROJECT_ID
```  
Attribute mapping:  
Biến ánh xạ thuộc tính ánh xạ các thuộc tính từ thông tin xác thực do Gitlab cấp sang thuộc tính Google Cloud.   có thể tìm thấy danh sách đầy đủ các thuộc tính của [Gitlab](https://docs.gitlab.com/ee/ci/cloud_services/google_cloud/) tại đây.   có thể ánh xạ tới các thuộc tính sau của Google Cloud:  
- **google.subject:** Bắt buộc. Nó phải được ánh xạ để Google biết ai là chủ thể đưa ra yêu cầu. Trong trường hợp của Gitlab, chúng tôi ánh xạ nó tới `assertion.sub`. Ngay cả khi nó là bắt buộc, giá trị này sẽ không ảnh hưởng đến kiến ​​trúc của chúng ta trừ khi   đặt nó làm điều kiện cho liên kết IAM tập hợp chính mà chúng ta sẽ thấy sau.
- **attribute.NAME:** Có thể tạo các thuộc tính mới mà Google chưa có để   có thể ánh xạ chúng tới những thuộc tính mà Gitlab cung cấp, điều này sẽ cho phép   đặt điều kiện về những người có thể truy cập vào tài khoản dịch vụ sẽ bị nhóm mạo danh. Trong trường hợp của chúng tôi, chúng tôi sẽ muốn ánh xạ tên không gian làm việc để mỗi không gian làm việc chỉ có thể truy cập vào tài khoản dịch vụ đã chọn.  
## Step 3: Create a service account that the gitlab external identity can impersonate.
```
#Create a service account
gcloud iam service-accounts create gitlab-wif-demo --project=$GCP_PROJECT_ID

#Add sample permissions to the Service account
gcloud projects add-iam-policy-binding $GCP_PROJECT_ID \
  --member=serviceAccount:gitlab-wif-demo@${GCP_PROJECT_ID}.iam.gserviceaccount.com \
  --role=roles/storage.admin \
  --role=roles/compute.instanceAdmin
```
## Step 4: Grant the gitlab external identity permissions to impersonate the Service Account, enabling a GitLab CI/CD job to authorize Google Cloud via Service Account impersonation
```
PROJECT_NUMBER=$(gcloud projects describe $(gcloud config get-value core/project) --format=value\(projectNumber\) --project $GCP_PROJECT_ID)

gcloud iam service-accounts add-iam-policy-binding gitlab-wif-demo@${GCP_PROJECT_ID}.iam.gserviceaccount.com \
    --role=roles/iam.workloadIdentityUser \
    --member="principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/gitlab-demo-wip/*"
```
![image](https://github.com/HuyPham01/docs/assets/96679595/b1a568fd-cf6c-4b63-ac8c-4d1102ca5784)  
**[Demo code show storage gcp](./show-storage.md)**  
[deploy](https://cloud.google.com/iam/docs/workload-identity-federation-with-deployment-pipelines#create_the_workload_identity_pool_and_provider)
