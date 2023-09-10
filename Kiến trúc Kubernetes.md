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
### Các thành phần được cài đặt trên Worker node bao gồm:

- ***Kubelet:*** Thực hiện tương tác với container runtime để quản trị vòng đời ứng dụng chạy trong container
- ***Kube-proxy:*** Tương tác với iptables để thiết lập các chính sách truy cập
- ***Container runtime:*** Thực hiện pull image, start và stop container theo chỉ thị từ kubelet  
![image](https://github.com/HuyPham01/docs/assets/96679595/1c32e815-9828-46f0-bad3-d11020795708)
##  Worker node và Master node giao tiếp với nhau như thế nào?
![image](https://github.com/HuyPham01/docs/assets/96679595/d05ae18b-3e93-40e6-8600-102e8555ffd0)
API server chính là cửa ngõ cho mọi giao tiếp giữa các thành phần, kể cả gõ lệnh tương tác qua CLI (Command Line Interface) hay qua RESTful API thì cũng phải qua API server.  

Từ Worker node, thì kube-proxy và Kubelet gọi tới API server để báo cáo trạng thái cũng như nhận các chỉ thị cần thực hiện.  

Trong nội tại Master node thì chỉ có API server mới có thể tương tác với etcd. Có khi nào API server chủ động kết nối tới các Worker node không? Ở hình trên không có luồng mũi tên trỏ từ Master node sang Worker node, nhưng câu trả lời là có. Kết nối từ API server sang Worker node thực hiện lúc nào? Đó là khi bạn thực hiện gửi yêu cầu kết nối tới các container. Cụ thể là khi lấy log ở các stdout, hay thực hiện truy cập vào console của container. API server sẽ kết nối tới Kubelet để thực hiện các truy cập vào container.  
# Mô hình kiến trúc hạ tầng Kubernetes Cluster có đảm bảo tính sẵn sàng cao (High Availability) [Link](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/)
![image](https://github.com/HuyPham01/docs/assets/96679595/eeea3167-0b77-4914-a8bf-ccdea4ebf595)




