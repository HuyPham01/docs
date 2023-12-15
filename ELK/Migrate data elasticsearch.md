
M`igrate dữ liệu Elasticsearch từ Server cũ sang Server mới một cách nhanh chóng sử dụng `elasticdump`.
# Step 1 
Cài npm:
```bash
apt install npm
```
# Step 2
Cài `elasticdump`
```bash
npm install elasticdump -g
```
# syntax
Định dạng của Elasticsearch URL:
- {protocol}://{host}:{port}/{index}
- Ví dụ: http://127.0.0.1:9200/my_index
Copy data từ Server 192.168.100.150 sang 192.168.100.86:  
```bash
elasticdump \
  --input=http://192.168.100.150:9200/my_index \
  --output=http://192.168.100.86:9200/my_index \
  --type=data
```
Nếu cần migrate cả mapping thì ta chạy câu lệnh migrate mapping trước:  
```bash
elasticdump \
  --input=http://192.168.100.150:9200/my_index \
  --output=http://192.168.100.86:9200/my_index \
  --type=mapping
elasticdump \
  --input=http://192.168.100.150:9200/my_index \
  --output=http://192.168.100.86:9200/my_index \
  --type=data
```
Trong Elasticsearch, mapping đóng vai trò vô cùng quan trọng, nó chính là quá trình định nghĩa cấu trúc dữ liệu và cách các trường thông tin (field) được lưu trữ, đánh chỉ mục và tìm kiếm. Nói đơn giản, mapping là bản đồ hướng dẫn cho Elasticsearch hiểu dữ liệu.  
  
Các chức năng chính của mapping:  
- Xác định kiểu dữ liệu: Mapping cho biết mỗi trường chứa loại dữ liệu nào, chẳng hạn như văn bản, số, ngày, vị trí địa lý, v.v. Điều này giúp Elasticsearch lưu trữ và xử lý dữ liệu hiệu quả hơn.
- Cấu trúc dữ liệu: Mapping giúp bạn thiết lập cấu trúc và mối quan hệ giữa các trường trong một document. Điều này cho phép bạn thực hiện các truy vấn phức tạp dựa trên các mối quan hệ này.
- Tùy chỉnh hành vi tìm kiếm: Mapping cho phép bạn tinh chỉnh cách các trường được đánh chỉ mục và tìm kiếm. Bạn có thể kích hoạt phân tích văn bản, tokenization, và các tùy chọn khác để cải thiện độ chính xác và hiệu quả của tìm kiếm.  
Chạy với self-sign certificate:
```bash
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
  --input=http://192.168.100.150:9200/my_index \
  --output=http://192.168.100.86:9200/my_index \
  --type=data
```
Chạy với basic http auth:  
```bash
elasticdump \
  --input=http://name:password@192.168.100.150:9200/my_index \
  --output=http://name:password@192.168.100.86:9200/my_index \
  --type=data
```



