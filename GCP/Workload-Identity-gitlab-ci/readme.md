# Sử dịch vụ GCP trong Pipelines CI/CD GitLab
Theo truyền thống, khi sử dụng các dịch vụ như Google Cloud trong môi trường không phải GCP (ví dụ: môi trường CI/CD như quy trình GitLab), nhà phát triển sẽ cần sử service account hoặc other long-lived credentials to authenticate with Google Cloud services. Tuy nhiên, phương pháp này có một số rủi ro về bảo mật:
