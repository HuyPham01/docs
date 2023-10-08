# Secure access to GKE workloads with Workload Identity
Quản lý quyền khối lượng công việc trong Kubernetes từ lâu đã là một nhiệm vụ đầy thách thức, đặc biệt là khi một nhóm cần truy cập tài nguyên đám mây. 
Điều này thường đòi hỏi phải sử dụng khóa tài khoản dịch vụ, việc này có thể gây khó khăn trong việc quản lý và gây ra rủi ro bảo mật. 
Workload Identity của Google là một giải pháp đổi mới trực tiếp giải quyết những thách thức này, đơn giản hóa các quyền và xác thực trong Kubernetes
# What is Workload Identity ?
Google Kubernetes Engine (GKE) Workload Identity là một tính năng cho phép ánh xạ Tài khoản dịch vụ Kubernetes 
với Tài khoản dịch vụ Google Cloud IAM (Quản lý danh tính và quyền truy cập) để người dùng có thể quản lý các quyền của nhóm bằng IAM.
## Một số trường hợp sử dụng workload identity có thể giúp tiết kiệm thời gian
- Đơn giản hóa việc xác thực: Không còn cần phải tạo và quản lý thông tin đăng nhập ứng dụng nữa. Thay vào đó,có thể sử dụng tài khoản dịch vụ IAM để xác thực tài nguyên Google Cloud.
- Tăng cường bảo mật: Bằng cách sử dụng tài khoản dịch vụ IAM, có thể kiểm soát quyền truy cập vào Google Cloud resources bằng các vai trò và chính sách IAM, giúp giảm rủi ro quản lý bí mật.
- Cải thiện khả năng quản lý: Bằng cách sử dụng tài khoản dịch vụ IAM,có thể thực thi nguyên tắc đặc quyền tối thiểu và giúp quản lý quyền truy cập các ứng dụng một cách dễ dàng hơn.
Một số trường hợp sử dụng phổ biến cho GKE Workload Identity bao gồm:  

Truy cập Google Cloud Storage: Nếu ứng dụng  yêu cầu quyền truy cập vào Google Cloud Storage,   có thể sử dụng GKE Workload Identity để truy cập an toàn vào bộ nhớ mà không cần quản lý thông tin đăng nhập ứng dụng.  
Truy cập Google BigQuery: Nếu ứng dụng của   yêu cầu quyền truy cập vào Google BigQuery,   có thể sử dụng GKE Workload Identity để truy cập dữ liệu một cách an toàn mà không cần quản lý thông tin đăng nhập ứng dụng.  
Truy cập Google Cloud SQL: Nếu ứng dụng của   yêu cầu quyền truy cập vào Google Cloud SQL,   có thể sử dụng GKE Workload Identity để truy cập cơ sở dữ liệu một cách an toàn mà không cần quản lý thông tin đăng nhập ứng dụng.  
## So sánh khi sử dụng Workload Identity và không sử dụng Workload Identity.
Accessing Google Cloud Storage. To set up GKE Workload Identity  
`Step1` : Enable workload identity on your Kubernetes cluster  
```bash
gcloud container clusters update <cluster-name> --workload-pool=<project-id>.svc.id.goog
```
> result 
```
$ gcloud container clusters update cluster-1 --zone europe-west9-a --workload-pool=poc-tgw.svc.id.goog
Default change: During creation of nodepools or autoscaling configuration changes for cluster versions greater than 1.24.1-gke.800 a default location policy is applied. For Spot and PVM it defaults to ANY, and for all other VM kinds a BALANCED policy is used. To change the default values use the `--location-policy` flag.
Updating cluster-1...
Updated [<https://container.googleapis.com/v1/projects/poc-tgw/zones/europe-west9-a/clusters/cluster-1>].
To inspect the contents of your cluster, go to: <https://console.cloud.google.com/kubernetes/workload_/gcloud/europe-west9-a/cluster-1?project=poc-tgw>
```
`Step 2` : Create a Google Cloud IAM Service Account  
```bash
gcloud iam service-accounts create iam-service-account \\ --display-name "Service account for my-app"
```
`Step 3`: Grant the necessary permissions to the IAM Service Account: For accessing Google Cloud Storage, you can grant the “Storage Object Viewer” role.  
```bash
gcloud projects add-iam-policy-binding <project-id> \
--member serviceAccount:iam-service-account@<
project-id>.iam.gserviceaccount.com \
--role roles/storage.objectViewer
```
`Step 4` : Create a Kubernetes Service Account  
```bash
kubectl create serviceaccount k8s-service-account
```
`Step 5` : Bind the Kubernetes Service Account to the IAM Service Account  
```bash
kubectl annotate serviceaccount k8s-service-account \
```



