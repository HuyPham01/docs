# Tổng quan
Trong K8s, Ingress là đối tượng sử dụng để expose service nằm bên trong Cluster ra bên ngoài Internet. Với Ingress, ta có thể tạo ra nhiều rule khác nhau để điều tiết traffic tới các services. Sử dụng Ingress để expose service sẽ đơn giản hơn sử dụng Load Balancer và expose service trên từng Node  

Ví dụ:  

- Khi có request tới domain example.com/api/v1/ sẽ tới api-v1 service,
- Khi có request tới domain example.com/api/v2/ sẽ tới api-v2 service,
# Thế nào là Ingress Controller?
Ingress Controller là một ứng dụng chạy trong một cluster và sử dụng cấu hình LoadBalancer HTTP theo tài nguyên Ingress. Loadbalancer này có thể là chạy bằng phần mềm trong cluster (MetalLB), Loadbalancer phần cứng hoặc là Loadbalancer dịch vụ cloud bên ngoài. Với mỗi LoadBalancer khác nhau đòi hỏi phải thực hiện Ingress Controller khác nhau.  
# Kubernetes Ingress vs LoadBalancer vs NodePort, ClusterIP
Các option trên đều sử dụng với mục đích Expose service từ nội bộ Cluster ra bên ngoài internet.  
## ClusterIP
ClusterIP là service mặc định của Kubernetes. Nó sẽ tạo ra một service trong cluster mà các ứng dụng khác trong cluster đều có thể kết nối. Không có kết nối ngoài.  
![image](https://github.com/HuyPham01/docs/assets/96679595/46b33c08-2e4e-43ab-b291-ee4a40ea5bc2)

## NodePort
NodePort Service là một trong những cách nguyên thủy nhất đễ kết nối external traffic trực tiếp tới service của bạn. NodePort sẽ mở một port trên tất cả các Nodes(VMs), băt cứ traffic nào tới các node này sẽ được chuyển tiếp đến service.  

Đánh giá:  

- Phương pháp cấu hình đơn giản, service được chọn dạng NodePort. Sau đó K8s sẽ cấp 1 Port xác định trên mỗi node thuộc Cluster cho service.
- Tất cả traffic tới Port sẽ được forward vào bên trong Service và tới các Pod bên trong
- Phương pháp có nhược điểm, quản lý Port cấp phát không rõ ràng, đôi khi cấp phát port chồng chéo, chỉ có thể sử dụng port từ 30000–32767
![image](https://github.com/HuyPham01/docs/assets/96679595/228595d4-25ed-48f0-b30a-53f21a361ba6)
![image](https://github.com/HuyPham01/docs/assets/96679595/0c9ac75f-0956-42f8-8f39-5ce7eaba5846)

## LoadBalancer
Đánh giá:

- Phương pháp cấu hình LoadBalancer khá giống NodePort – Sử dụng file YAML
- Tuy nhiên phương pháp yêu cầu External Loadblancer, thường được cung cấp bởi các cloud providerm, không sẵn khi cài Kubernetes mặc định.
- Với phương pháp cài thủ công, phải triển khai thêm thành phần LB khá phức tạp
- Khi có thành phần LB, mỗi khi tạo mới 1 service, thành phần LB sẽ cấp cho Service 1 IP External để người dùng truy cập. Đây cũng là IP để expose service k8s ra ngoài Internet.
![image](https://github.com/HuyPham01/docs/assets/96679595/9369353c-4a7a-4e39-9ae5-733960127699)  
![image](https://github.com/HuyPham01/docs/assets/96679595/0685b92c-3b1f-4fbb-9d76-10ce7ec478ad)

## Ingress
Không giống các ví dụ trên, Ingress không thực sự là một loại service. Thay vào đó, nó đứng trước nhiều services, và hoạt động như một smart router hoặc entry point tới cluster .  
Đánh giá:

- NodePort và LoadBalancer expose service bằng cách chỉ định service type. Ingress tiếp cập theo phương pháp khác
- Với Ingress, tập trung vào điều phối HTTP và HTTPs Request từ bên ngoài vào trong Cluster
- Có thể sử dụng kết hợp Ingress + LB hoặc Ingress + NodePort.
- Nếu sử dụng Ingress + NodePort thì ta sẽ không cần triển khai thành phần LB. Nhược điểm, chỉ có thể Expose Port từ 30000-32767
VD:  

- Khi có request tới domain example.com/api/v1/ sẽ tới api-v1 service,
- Khi có request tới domain example.com/api/v2/ sẽ tới api-v2 service,
Các loại Ingress Controller thông dụng:

- NGINX Ingress Controller
- HAProxy Ingress Controller
![image](https://github.com/HuyPham01/docs/assets/96679595/fb3e9df4-ec04-466d-a492-be2403bfa828)  
![image](https://github.com/HuyPham01/docs/assets/96679595/a6d6bbe5-3048-4da1-955c-69f7cdeab224)




