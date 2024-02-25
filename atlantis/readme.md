# Gitlab runner vs atlantis
## GitLab Runner:
***Chức năng:***  

GitLab Runner chủ yếu đảm nhiệm vai trò của một "executor" trong hệ thống CI/CD của GitLab. Nó thực hiện các công việc như build, test, và triển khai dựa trên cấu hình được đặt ra trong file `.gitlab-ci.yml.`  
GitLab Runner giúp kết nối GitLab và môi trường thực thi nơi các công việc CI/CD được thực hiện.  
***Triển khai:***  

GitLab Runner có thể triển khai trên nhiều nền tảng và hỗ trợ nhiều executor như Shell, Docker, Kubernetes, và nhiều loại executor khác.  
***Mô hình hoạt động:***  

GitLab Runner hoạt động như một agent được cài đặt trên môi trường triển khai. Nó lắng nghe các sự kiện từ GitLab và thực hiện các công việc CI/CD tương ứng.  
## Atlantis:  
***Chức năng:***  

Atlantis chủ yếu tập trung vào quản lý Infrastructure as Code (IaC) và quản lý các yêu cầu thay đổi hạ tầng thông qua mã nguồn.  
***Triển khai:***  

Atlantis thường được triển khai như một dịch vụ web (web service) và tích hợp với GitLab để quản lý các yêu cầu thay đổi Terraform.  
***Mô hình hoạt động:***  

Atlantis tương tác với GitLab thông qua webhook và quy trình thực hiện các thao tác Terraform dựa trên các yêu cầu thay đổi được mô tả trong các pull request.  
## Sự giống nhau:  
Cả hai đều liên quan đến quá trình quản lý mã nguồn và triển khai trên GitLab.  
Cả hai đều có thể tích hợp vào quy trình CI/CD của bạn.  
## Sự khác nhau:  
***Phạm vi chức năng:***  

GitLab Runner chủ yếu dành cho việc thực hiện công việc CI/CD.  
Atlantis chủ yếu tập trung vào quản lý hạ tầng và sử dụng chủ yếu cho Terraform.  
***Loại công việc:***  

GitLab Runner thực hiện công việc liên quan đến xây dựng, kiểm thử và triển khai ứng dụng.  
Atlantis thực hiện công việc quản lý thay đổi hạ tầng với Terraform.  
***Triển khai và mô hình hoạt động:***  

GitLab Runner thường triển khai trên môi trường thực thi và lắng nghe các sự kiện từ GitLab.  
Atlantis thường triển khai như một dịch vụ web và tương tác với GitLab thông qua webhook.  
- Tóm lại, GitLab Runner và Atlantis có mục tiêu chính khác nhau trong quy trình phát triển và triển khai, và chúng có thể được sử dụng cùng nhau để tạo ra một quy trình CI/CD hoàn chỉnh và quản lý hạ tầng.
