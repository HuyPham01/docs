![image](https://github.com/HuyPham01/docs/assets/96679595/884c2c35-ef71-43d3-adbf-320b72355e66)  
## VPC-Native & Route-Based Cluster GKE là hai loại cluster khác nhau được cung cấp bởi Google Kubernetes Engine (GKE).

- VPC-Native Cluster GKE: Là loại cluster sử dụng Alias IP address để định tuyến lưu lượng giữa các Pod(Secondary IP của subnetwork trong VPC ) để gán cho Pod IP/ Service IP. Điều này giúp cho VPC-native cluster có hiệu suất cao hơn và dễ quản lý hơn so với route-based cluster.
- Route-Based Cluster GKE: Là loại cluster sử dụng Google Cloud Routes để định tuyến lưu lượng giữa các Pod. Google Cloud Routes là một tính năng của Google Cloud Networking cho phép bạn tạo và quản lý các tuyến tĩnh. Giúp xác điểm cuối của request.
Ưu điểm và nhược điểm của VPC-Native Cluster GKE  

Ưu điểm:  

- Hiệu suất cao hơn so với route-based cluster.  
- Dễ quản lý hơn so với route-based cluster.  
- Không cần phải tạo và quản lý các tuyến tĩnh.
  
Nhược điểm:  

- Yêu cầu sử dụng một subnet trong VPC network.
- Không hỗ trợ IPv6.
Ưu điểm và nhược điểm của Route-Based Cluster GKE  

Ưu điểm:  

- Hỗ trợ IPv6.  
- Có thể sử dụng nhiều subnet trong VPC network.
  
Nhược điểm:  

- Hiệu suất thấp hơn so với VPC-native cluster.
- Khó quản lý hơn so với VPC-native cluster.
- Cần phải tạo và quản lý các tuyến tĩnh.
## Lưu ý: VPC-native cluster là loại cluster được khuyến nghị sử dụng cho hầu hết các trường hợp.
