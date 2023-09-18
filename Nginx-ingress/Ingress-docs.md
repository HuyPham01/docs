# Tổng quan
Trong K8s, Ingress là đối tượng sử dụng để expose service nằm bên trong Cluster ra bên ngoài Internet. Với Ingress, ta có thể tạo ra nhiều rule khác nhau để điều tiết traffic tới các services. Sử dụng Ingress để expose service sẽ đơn giản hơn sử dụng Load Balancer và expose service trên từng Node  

Ví dụ:  

- Khi có request tới domain example.com/api/v1/ sẽ tới api-v1 service,
- Khi có request tới domain example.com/api/v2/ sẽ tới api-v2 service,
