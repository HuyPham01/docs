# <kubernetes_sd_config>
Cấu hình Kubernetes SD cho phép truy xuất các mục tiêu cóp nhặt từ API REST của Kubernetes và luôn được đồng bộ hóa với trạng thái cụm.  
  
Một trong rolecác loại sau có thể được cấu hình để khám phá các mục tiêu:  

## node
Vai trò này `node`phát hiện một mục tiêu trên mỗi nút cụm với địa chỉ mặc định là cổng HTTP của Kubelet. Địa chỉ đích mặc định là địa chỉ hiện có đầu tiên của đối tượng nút Kubernetes theo thứ tự loại địa chỉ là `NodeInternalIP`, `NodeExternalIP`, `NodeLegacyHostIP`và `NodeHostName`.

Nhãn meta có sẵn:

- `__meta_kubernetes_node_name`: Tên của đối tượng nút.
- `__meta_kubernetes_node_provider_id`: Tên nhà cung cấp đám mây cho đối tượng nút.
- `__eta_kubernetes_node_label_<labelname>`: Mỗi nhãn từ đối tượng nút.
- `__meta_kubernetes_node_labelpresent_<labelname>`: `true`cho mỗi nhãn từ đối tượng nút.
- `__meta_kubernetes_node_annotation_<annotationname>`: Mỗi chú thích từ đối tượng nút.
- `__meta_kubernetes_node_annotationpresent_<annotationname>`: `true`cho mỗi chú thích từ đối tượng nút.
- `__meta_kubernetes_node_address_<address_type>`: Địa chỉ đầu tiên cho từng loại địa chỉ nút, nếu nó tồn tại.
Ngoài ra, instancenhãn cho nút sẽ được đặt thành tên nút được truy xuất từ ​​máy chủ API.  

## service
Vai trò này `service`phát hiện mục tiêu cho từng cổng dịch vụ cho mỗi dịch vụ. Điều này thường hữu ích cho việc giám sát hộp đen của một dịch vụ. Địa chỉ sẽ được đặt thành tên DNS Kubernetes của dịch vụ và cổng dịch vụ tương ứng.  

Nhãn meta có sẵn:

- `__meta_kubernetes_namespace`: Không gian tên của đối tượng dịch vụ.
- `__meta_kubernetes_service_annotation_<annotationname>`: Mỗi chú thích từ đối tượng dịch vụ.
- `__meta_kubernetes_service_annotationpresent_<annotationname>`: "`true`" cho mỗi chú thích của đối tượng dịch vụ.
- `__meta_kubernetes_service_cluster_ip`: Địa chỉ IP cụm của dịch vụ. (Không áp dụng cho các dịch vụ thuộc loại externalName)
- `__meta_kubernetes_service_loadbalancer_ip`: Địa chỉ IP của bộ cân bằng tải. (Áp dụng cho các dịch vụ thuộc loại LoadBalancer)
- `__meta_kubernetes_service_external_name`: Tên DNS của dịch vụ. (Áp dụng cho các dịch vụ thuộc loại externalName)
- `__meta_kubernetes_service_label_<labelname>`: Mỗi nhãn từ đối tượng dịch vụ.
- `__meta_kubernetes_service_labelpresent_<labelname>`: `true`cho mỗi nhãn của đối tượng dịch vụ.
- `__meta_kubernetes_service_name`: Tên đối tượng dịch vụ.
- `__meta_kubernetes_service_port_name`: Tên cổng dịch vụ cho mục tiêu.
- `__meta_kubernetes_service_port_number`: Số cổng dịch vụ cho mục tiêu.
- `__meta_kubernetes_service_port_protocol`: Giao thức của cổng dịch vụ cho mục tiêu.
- `__meta_kubernetes_service_type`: Loại dịch vụ.
## pod
Vai trò này `pod`sẽ khám phá tất cả các nhóm và hiển thị các thùng chứa của chúng làm mục tiêu. Đối với mỗi cổng được khai báo của một container, một mục tiêu duy nhất sẽ được tạo. Nếu một vùng chứa không có cổng được chỉ định, mục tiêu không có cổng cho mỗi vùng chứa sẽ được tạo để thêm cổng theo cách thủ công thông qua việc dán nhãn lại.  

Nhãn meta có sẵn:

- `__meta_kubernetes_namespace`: Không gian tên của đối tượng nhóm.
- `__meta_kubernetes_pod_name`: Tên của đối tượng nhóm.
- `__meta_kubernetes_pod_ip`: IP nhóm của đối tượng nhóm.
- `__meta_kubernetes_pod_label_<labelname>`: Mỗi nhãn từ đối tượng nhóm.
- `__meta_kubernetes_pod_labelpresent_<labelname>`: `true`cho mỗi nhãn từ đối tượng nhóm.
- `__meta_kubernetes_pod_annotation_<annotationname>`: Mỗi chú thích từ đối tượng nhóm.
- `__meta_kubernetes_pod_annotationpresent_<annotationname>`: `true`cho mỗi chú thích từ đối tượng nhóm.
- `__meta_kubernetes_pod_container_init`: `true`nếu vùng chứa là InitContainer
- `__meta_kubernetes_pod_container_name`: Tên của container mà địa chỉ đích trỏ tới.
- `__meta_kubernetes_pod_container_id`: ID của container mà địa chỉ đích trỏ tới. ID có dạng <type>://<container_id>.
- `__meta_kubernetes_pod_container_image`: Hình ảnh mà vùng chứa đang sử dụng.
- `__meta_kubernetes_pod_container_port_name`: Tên cảng container.
- `__meta_kubernetes_pod_container_port_number`: Số cảng container.
- `__meta_kubernetes_pod_container_port_protocol`: Giao thức của cảng container.
- `__meta_kubernetes_pod_ready`: Đặt thành `true`hoặc `false`cho trạng thái sẵn sàng của nhóm.
- `__meta_kubernetes_pod_phase`: Đặt thành Pending, Running, Succeededhoặc Failedtrong Unknown vòng đời .
- `__meta_kubernetes_pod_node_name`: Tên của nút mà nhóm được lên lịch.
- `__meta_kubernetes_pod_host_ip`: IP máy chủ hiện tại của đối tượng nhóm.
- `__meta_kubernetes_pod_uid`: UID của đối tượng nhóm.
- `__meta_kubernetes_pod_controller_kind`: Loại đối tượng của bộ điều khiển pod.
- `__meta_kubernetes_pod_controller_name`: Tên của bộ điều khiển nhóm.
## endpoints
Vai trò này `endpoints`phát hiện các mục tiêu từ các điểm cuối được liệt kê của dịch vụ. Đối với mỗi địa chỉ điểm cuối, một mục tiêu được phát hiện trên mỗi cổng. Nếu điểm cuối được hỗ trợ bởi một nhóm thì tất cả các cổng container bổ sung của nhóm, không bị ràng buộc với cổng điểm cuối, cũng được phát hiện là mục tiêu.  

Nhãn meta có sẵn:

- `__meta_kubernetes_namespace`: Không gian tên của đối tượng điểm cuối.
- `__meta_kubernetes_endpoints_name`: Tên của đối tượng điểm cuối.
- `__meta_kubernetes_endpoints_label_<labelname>`: Mỗi nhãn từ đối tượng điểm cuối.
- `__meta_kubernetes_endpoints_labelpresent_<labelname>`: `true`cho mỗi nhãn từ đối tượng điểm cuối.
- `__meta_kubernetes_endpoints_annotation_<annotationname>`: Mỗi chú thích từ đối tượng điểm cuối.
- `__meta_kubernetes_endpoints_annotationpresent_<annotationname>`: `true`cho mỗi chú thích từ đối tượng điểm cuối.
- Đối với tất cả các mục tiêu được phát hiện trực tiếp từ danh sách điểm cuối (những mục tiêu không được suy ra thêm từ nhóm cơ bản), các nhãn sau sẽ được đính kèm:
    - `__meta_kubernetes_endpoint_hostname`: Tên máy chủ của điểm cuối.
    - `__meta_kubernetes_endpoint_node_name`: Tên của nút lưu trữ điểm cuối.
    - `__meta_kubernetes_endpoint_ready`: Đặt thành `true`hoặc `false`cho trạng thái sẵn sàng của điểm cuối.
    - `__meta_kubernetes_endpoint_port_name`: Tên cổng điểm cuối.
    - `__meta_kubernetes_endpoint_port_protocol`: Giao thức của cổng điểm cuối.
    - `__meta_kubernetes_endpoint_address_target_kind`: Loại địa chỉ đích của điểm cuối.
    - `__meta_kubernetes_endpoint_address_target_name`: Tên của địa chỉ điểm cuối đích.
Nếu điểm cuối thuộc về một dịch vụ thì tất cả các nhãn của `role: service`khám phá sẽ được đính kèm.
Đối với tất cả các mục tiêu được hỗ trợ bởi một nhóm, tất cả các nhãn của `role: pod`khám phá đều được đính kèm.
## endpointslice
Vai trò này `endpointslice`phát hiện các mục tiêu từ các lát điểm cuối hiện có. Đối với mỗi địa chỉ điểm cuối được tham chiếu trong đối tượng lát cắt điểm cuối, một mục tiêu được phát hiện. Nếu điểm cuối được hỗ trợ bởi một nhóm thì tất cả các cổng container bổ sung của nhóm, không bị ràng buộc với cổng điểm cuối, cũng được phát hiện là mục tiêu.  

Nhãn meta có sẵn:

- `__meta_kubernetes_namespace`: Không gian tên của đối tượng điểm cuối.
- `__meta_kubernetes_endpointslice_name`: Tên của đối tượng endpointslice.
- `__meta_kubernetes_endpointslice_label_<labelname>:` Mỗi nhãn từ đối tượng endpointslice.
- `__meta_kubernetes_endpointslice_labelpresent_<labelname>:` `true`cho mỗi nhãn từ đối tượng lát cắt điểm cuối.
- `__meta_kubernetes_endpointslice_annotation_<annotationname>:` Mỗi chú thích từ đối tượng endpointslice.
- `__meta_kubernetes_endpointslice_annotationpresent_<annotationname>`: `true`cho mỗi chú thích từ đối tượng endpointslice.
- Đối với tất cả các mục tiêu được phát hiện trực tiếp từ danh sách lát điểm cuối (những mục tiêu không được suy ra bổ sung từ các nhóm cơ bản), các nhãn sau sẽ được đính kèm:
    - `__meta_kubernetes_endpointslice_address_target_kind`: Loại đối tượng được tham chiếu.
    - `__meta_kubernetes_endpointslice_address_target_name`: Tên đối tượng được tham chiếu.
    - `__meta_kubernetes_endpointslice_address_type`: Họ giao thức IP của địa chỉ mục tiêu.
    - `__meta_kubernetes_endpointslice_endpoint_conditions_ready`: Đặt thành `true`hoặc `false`cho trạng thái sẵn sàng của điểm cuối được tham chiếu.
    - `__meta_kubernetes_endpointslice_endpoint_conditions_serving`: Đặt thành `true`hoặc `false`cho trạng thái phục vụ của điểm cuối được tham chiếu.
    - `__meta_kubernetes_endpointslice_endpoint_conditions_terminating`: Đặt thành `true`hoặc `false`cho trạng thái kết thúc của điểm cuối được tham chiếu.
    - `__meta_kubernetes_endpointslice_endpoint_topology_kubernetes_io_hostname`: Tên của nút lưu trữ điểm cuối được tham chiếu.
    - `__meta_kubernetes_endpointslice_endpoint_topology_present_kubernetes_io_hostname`: Cờ cho biết đối tượng được tham chiếu có chú thích kubernetes.io/hostname hay không.
    - `__meta_kubernetes_endpointslice_port`: Cổng của điểm cuối được tham chiếu.
    - `__meta_kubernetes_endpointslice_port_name`: Cổng được đặt tên của điểm cuối được tham chiếu.
    - `__meta_kubernetes_endpointslice_port_protocol`: Giao thức của điểm cuối được tham chiếu.
Nếu điểm cuối thuộc về một dịch vụ thì tất cả các nhãn của `role: servicek`hám phá sẽ được đính kèm.
Đối với tất cả các mục tiêu được hỗ trợ bởi một nhóm, tất cả các nhãn của `role: pod`khám phá đều được đính kèm.
## ingress
Vai trò này `ingress`phát hiện ra mục tiêu cho mỗi đường đi của mỗi lần xâm nhập. Điều này thường hữu ích cho việc giám sát hộp đen của một lần xâm nhập. Địa chỉ sẽ được đặt thành máy chủ được chỉ định trong thông số lối vào.  

Nhãn meta có sẵn:

- `__meta_kubernetes_namespace`: Không gian tên của đối tượng xâm nhập.
- `__meta_kubernetes_ingress_name`: Tên của đối tượng xâm nhập.
- `__meta_kubernetes_ingress_label_<labelname>:` Mỗi nhãn từ đối tượng xâm nhập.
- `__meta_kubernetes_ingress_labelpresent_<labelname>`: `true`cho mỗi nhãn từ đối tượng xâm nhập.
- `__meta_kubernetes_ingress_annotation_<annotationname>:` Mỗi chú thích từ đối tượng xâm nhập.
- `__meta_kubernetes_ingress_annotationpresent_<annotationname>:` `true`cho mỗi chú thích từ đối tượng xâm nhập.
- `__meta_kubernetes_ingress_class_name`: Tên lớp từ thông số lối vào, nếu có.
- `__meta_kubernetes_ingress_scheme`: Sơ đồ giao thức xâm nhập, httpsnếu cấu hình TLS được đặt. Mặc định là http.
- `__meta_kubernetes_ingress_path`: Đường dẫn từ thông số kỹ thuật xâm nhập. Mặc định là `/.`

