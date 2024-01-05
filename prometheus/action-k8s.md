Trong cấu hình Prometheus, `action` trong `relabel_configs` định nghĩa hành động cụ thể.  
Để thực hiện trên các labels hoặc giá trị của metrics target được phát hiện.  
Đây là một số giá trị phổ biến cho action và ý nghĩa của chúng:  
1. `replace`: Thay thế giá trị của một label bằng giá trị mới. Điều này thường được sử dụng để đổi tên hoặc định dạng lại các labels.  
```
- action: replace
  source_labels: [__meta_kubernetes_node_name]
  regex: (.+)
  target_label: instance
  replacement: $1:9100
```
Trong ví dụ này, nếu label `__meta_kubernetes_node_name` có giá trị là "node-1", label `instance` sẽ được thiết lập thành `node-1:9100`.  
2. `labelmap`: Chuyển đổi các labels từ một dạng định danh (đặc trưng của Kubernetes)  
thành dạng phổ biến hơn (đặc trưng của Prometheus). Điều này giúp tổ chức và tạo labels có ý nghĩa hơn.  
```
- action: labelmap
  regex: __meta_kubernetes_node_label_(.+)
```
Trong ví dụ này, nếu có một label có tên là `__meta_kubernetes_node_label_x`, nó sẽ được chuyển thành x.  
3. `keep`: Giữ lại hoặc loại bỏ các metrics dựa trên điều kiện nhất định.  
```
- action: keep
  source_labels: [__meta_kubernetes_pod_label_grafanak8sapp]
  regex: .*true.*
```
Trong ví dụ này, metrics chỉ được giữ lại nếu label `__meta_kubernetes_pod_label_grafanak8sapp` có giá trị là `true.`  
4. `drop`: Xóa các metrics dựa trên điều kiện nhất định.  
```
- action: drop
  source_labels: [__meta_kubernetes_pod_label_grafanak8sapp]
  regex: .*false.*
```
Trong ví dụ này, metrics sẽ bị loại bỏ nếu label `__meta_kubernetes_pod_label_grafanak8sapp` có giá trị là `false.`  
`action` cùng với các quy tắc tái định dạng khác trong `relabel_configs`.    
linh động và tùy chỉnh cách Prometheus tổ chức và xử lý các metrics từ các target được phát hiện.  
