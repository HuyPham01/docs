Kubernetes Cluster được chia ra làm 2 khối: Control plane và Data plane. Mỗi khối này sẽ có các vai trò và chức năng khác nhau.  
Đầu tiên là khối Control Plane. Như tên gọi đã phản ánh, thì khối này sẽ thực hiện các công tác điều khiển như kiểm tra dữ liệu truyền vào, phân tích yêu cầu để đưa ra chỉ thị cho các thành phần khác thực thi  
Tiếp theo là khối Data Plane. Chính là nơi mà mọi ứng dụng sẽ triển khai trên đó. Nơi tiêu thụ RAM, CPU, Bandwidth chính của toàn bộ Kubernetes Cluster.  
Khi cài đặt, khối control plane sẽ cài đặt trên máy chủ được gọi là Master node. Còn khối data plane sẽ cài đặt trên máy chủ gọi là Worker node, hay Worker.  
Việc tính toán cấu hình máy chủ của hai khối này tương đối khác nhau. Với Master node thì bạn sẽ sizing sao cho nó đảm bảo được tính sẵn sàng cao (nhiều hơn 2 máy chủ), và cấu hình để làm sao quản lý được số lượng Worker node. Tại sao? Vì các Worker sẽ giao tiếp với Master để báo cáo cũng như nhận chỉ thị, càng nhiều Worker node thì cấu hình càng phải cao. Vậy thôi. Sizing cho Worker node thì đơn giản hơn. Cứ sao cho chẳng may một Worker node bị tắt, các Worker node còn lại vẫn đủ tài nguyên chạy ứng dụng.  
### Các thành phần được cài đặt trên Master node bao gồm:
- ***API server:*** Là đầu vào của mọi kết nối trong Kubernetes Cluster
- ***Cluster store:*** Lưu trữ thông tin của toàn bộ Kubernetes Cluster. Mặc định sử dụng là etcd. Mình đọc đâu đó thì có một giải pháp thay thế etcd bằng sqlite cho hệ thống siêu nhỏ.
- ***Controller manager:*** Thực hiện các công tác điều khiển vòng lặp (control loop). Có rất nhiều thành phần điều khiển nhỏ hơn bên trong như Replication controller, Node controller, Endpoints controller,…. Chúng ta sẽ đi dần trong chuỗi bài này
- ***Scheduler:*** Thực hiện việc lập lịch để chạy ứng dụng trên các Worker node.
![image](https://github.com/HuyPham01/docs/assets/96679595/7680e701-c5d7-4434-911d-2559c6bf1ed1)

