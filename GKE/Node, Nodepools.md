# Node và nodepool trong GKE là hai khái niệm khác nhau nhưng có liên quan chặt chẽ với nhau.

- Node (nút) là một máy tính ảo (Compute Engine VM instance) chạy Container Runtime cùng với Kubernetes Node Agent: kubelet để giao tiếp với Control Plane. Mỗi node trong một cluster GKE đều có một vai trò cụ thể, chẳng hạn như chạy các container hoặc lưu trữ dữ liệu. Từ GKE Node 1.19, Docker container runtime đã bị deprecated đã đổi sang dùng Containerd.  
- Nodepool (nhóm nút) là một nhóm các node có cùng cấu hình. Nodepool giúp bạn dễ dàng quản lý và mở rộng cluster GKE của mình.
Khi khởi tạo một cluster GKE, sẽ được yêu cầu tạo một nodepool đầu tiên. Nodepool này sẽ chứa các node chạy các container. Có thể tạo thêm nodepool bất cứ lúc nào để mở rộng cluster của mình.  

Mỗi node trong một cluster GKE đều có một nhãn `(label) cloud.google.com/gke-nodepool` với giá trị là tên của nodepool mà node đó thuộc về. Nhãn này giúp bạn dễ dàng xác định các node trong một nodepool cụ thể.

Có thể sử dụng Kubernetes CLI hoặc Google Cloud Console để quản lý nodepool trong cluster GKE. Có thể sử dụng Kubernetes CLI để tạo, xóa hoặc cập nhật nodepool. Cũng có thể sử dụng Google Cloud Console để xem thông tin về các nodepool trong cluster của mình.  

Dưới đây là một số lợi ích của việc sử dụng nodepool trong GKE:  
- Dễ dàng mở rộng cluster: Nodepool giúp dễ dàng mở rộng cluster GKE của mình bằng cách thêm hoặc xóa các node.  
- Quản lý dễ dàng: Nodepool giúp dễ dàng quản lý các node trong cluster GKE của mình bằng cách cung cấp một lớp trừu tượng cho các node.  
- Cải thiện hiệu suất: Nodepool có thể giúp cải thiện hiệu suất của cluster GKE của bằng cách cho phép bạn phân phối các container của mình trên các node có cấu hình khác nhau.  
- Cải thiện khả năng sẵn sàng: Nodepool có thể giúp cải thiện khả năng sẵn sàng của cluster GKE bằng cách cho phép bạn phân phối các container của mình trên nhiều node.  
Dưới đây là một số ví dụ về khi nào bạn nên sử dụng nodepool trong GKE:  
- Cần mở rộng cluster của mình một cách dễ dàng: Nếu Cần mở rộng cluster GKE của mình một cách dễ dàng và nhanh chóng, thì nên sử dụng nodepool.
- Cần quản lý các node của mình một cách dễ dàng: Nếu Cần quản lý các node trong cluster GKE của mình một cách dễ dàng, thì nên sử dụng nodepool.
- Cần cải thiện hiệu suất của cluster của mình: Nếu Cần cải thiện hiệu suất của cluster GKE của mình, thì có thể sử dụng nodepool để phân phối các container của mình trên các node có cấu hình khác nhau.
- Cần cải thiện khả năng sẵn sàng của cluster của mình: Nếu Cần cải thiện khả năng sẵn sàng của cluster GKE của mình, thì có thể sử dụng nodepool để phân phối các container của mình trên nhiều node.
