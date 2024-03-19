# Replica set trong mongodb là gì ?
Một replica set trong MongoDB là một nhóm các tiến trình của mongodb duy trì cùng một bộ dữ liệu. Các replica set cung cấp tính dự phòng và tính sẵn sàng cao và là cơ sở để triển khai nhập xuất dữ liệu khi cần thiết.
# Tính dự phòng và sẵn sàng trong Replication
Bản sao của cơ sở dữ liệu có tính dự phòng và khả dụng cao. Với nhiều bản sao dữ liệu trên các máy chủ cơ sở dữ liệu khác nhau, việc sao chép cung cấp mức độ chịu lỗi và chống lại việc mất một máy chủ cơ sở dữ liệu.  
Trong một số trường hợp, chúng ta có thể cài đặt việc đọc dữ liệu trên bản sao chép giúp việc lấy ra dữ liệu nhanh hơn. Việc duy trì các bản sao dữ liệu trong các trung tâm dữ liệu khác nhau có thể làm tăng tính cục bộ và tính khả dụng của dữ liệu cho các ứng dụng phân tán. Bạn cũng có thể duy trì các bản sao bổ sung cho các mục đích chuyên dụng, như khôi phục, báo cáo hoặc sao lưu.
# Mô hình của replica set trong mongodb
![image](https://github.com/HuyPham01/docs/assets/96679595/7248384b-bbb2-4f43-b254-c32650d6c3a9)  

Một replica set chỉ có duy nhất một primary. Primary member sẽ nhận các yêu cầu ghi. Primary ghi các thay đổi của nó vào `oplog` - một file có vai trò như `binlog` trên ***mysqld***.  
Các secondary sẽ có chung data set với primary, các yêu cầu đọc có thể scale trên primary và tất cả các secondary. Một replica set có thể có tối đa là 50 member.  
Các member luôn giữ duy trì kết nối, trong trường hợp một member chết thì các member khác sẽ tự động được chuyển đổi dự phòng. Đây là một điểm khác biệt so với mysql. 
#  Tự động chuyển đổi dự phòng (Automatic Failover)
![image](https://github.com/HuyPham01/docs/assets/96679595/633c47cb-774a-457a-a9f2-3f3faaabe7fe)  
Cơ chế tự động chuyển đổi dự phòng của replica set là dựa trên voting  
Khi một primary không hoạt động một secondary sẽ được bầu lên làm primary của cả replica set.  
Để voting thành công thì số member trong một replica set phải là số lẻ nếu không sẽ xảy ra trường hợp hai ứng viên đều nhận được số phiếu bầu bằng nhau rốt cục chẳng ai làm primary cả hoặc có thể dẫn đến tình huống có hai member đều tự nhận là primary nếu network partition xảy ra.  
