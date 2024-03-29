![Badge: Google Cloud](https://img.shields.io/badge/Google%20Cloud-%234285F4.svg?logo=google-cloud&logoColor=white)
[![Badge: Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?logo=terraform&logoColor=white)](https://github.com/Cyclenerd/google-workload-identity-federation/tree/master/allow/examples#readme)
[![Badge: GitHub](https://img.shields.io/badge/GitHub-181717.svg?logo=github&logoColor=white)](./github.md)
[![Badge: GitLab](https://img.shields.io/badge/GitLab-FC6D26.svg?logo=gitlab&logoColor=white)](./gitlab.md)
# Sử dịch vụ GCP trong Pipelines CI/CD GitLab
Theo truyền thống, khi sử dụng các dịch vụ như Google Cloud trong môi trường không phải GCP (ví dụ: môi trường CI/CD như quy trình GitLab), nhà phát triển sẽ cần sử service account hoặc other long-lived credentials to authenticate with Google Cloud services. Tuy nhiên, phương pháp này có một số rủi ro về bảo mật:  
- **Long-Term Credential Exposure: Service account keys are long-lived credentials**,thường có giá trị cho đến khi bị thu hồi hoặc xoay vòng theo cách thủ công. Việc lưu trữ các khóa này trong kho mã nguồn, tệp cấu hình hoặc môi trường CI/CD sẽ làm tăng nguy cơ truy cập trái phép nếu các kho lưu trữ hoặc environments này bị xâm phạm.
- **Privilege Escalation: Service account keys** thường có các quyền rộng được thiết kế để thực hiện nhiều tác vụ khác nhau trong Google Cloud. Nếu kẻ tấn công có được quyền truy cập vào khóa tài khoản dịch vụ, chúng có thể truy cập vào nhiều loại tài nguyên, có thể vượt xa mức cần thiết cho một ứng dụng hoặc khối lượng công việc cụ thể.
## GCP workload identity federation :
giải quyết những mối lo ngại về bảo mật này và cho phép bạn sử dụng nhà cung cấp danh tính (IdP) hiện có của mình để xác thực với Google Cloud Platform (GCP). Điều này có thể hữu ích cho quy trình GitLab vì nó cho phép sử dụng thông tin xác thực GitLab của mình để xác thực với GCP mà không cần quản lý các tài khoản dịch vụ hoặc thông tin xác thực riêng biệt.  
Các thành phần chính:
- **Identity provider (IdP):** IdP là hệ thống xác thực người dùng và cấp cho họ thông tin xác thực. GCP hỗ trợ nhiều nhà cung cấp danh tính khác nhau như Dịch vụ liên kết Active Directory (ADFS), Okta, Azure Active Directory hoặc bất kỳ nhà cung cấp danh tính nào hỗ trợ OpenID Connect (OIDC) hoặc SAML 2.0.
- **Workload identity pool:** Một thực thể cho phép quản lý danh tính bên ngoài. GCP khuyên bạn nên tạo một nhóm mới cho từng môi trường không phải của Google Cloud cần truy cập vào tài nguyên của Google Cloud.
- **Service account:** Trong GCP, tài khoản dịch vụ được sử dụng để thể hiện khối lượng công việc. Để truy cập tài nguyên, danh tính nhóm phải được cấp quyền truy cập vào tài khoản dịch vụ. Sau khi được thêm, những danh tính này sẽ có quyền truy cập vào mọi dịch vụ Google Cloud mà tài khoản dịch vụ có thể truy cập.
- **Federated token:** Mã thông báo liên kết là mã thông báo do IdP phát hành và được đổi lấy mã thông báo tài khoản dịch vụ. Mã thông báo liên kết cho phép khối lượng công việc xác thực GCP dưới dạng tài khoản dịch vụ.
## Cách liên kết IdP gcp vào gitlab pipelines
## Cần có
- Ensure you have the Workload Identity Pool Admin `(roles/iam.workloadIdentityPoolAdmin)` and Service Account Admin `(roles/iam.serviceAccountAdmin)` roles on the project.
```
export GCP_PROJECT_ID="value"
gcloud services enable cloudresourcemanager.googleapis.com \
iam.googleapis.com \
iamcredentials.googleapis.com \
sts.googleapis.com \
--project $GCP_PROJECT_ID
```
* **[Create user](./Create-gitlab-account.md)**
