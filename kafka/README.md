# Kafka hoạt động như thế nào?
Kafka được xây dựng dựa trên mô hình publish/subcribe, tương tự như bất kỳ hệ thống message nào khác. 
Các ứng dụng (đóng vai trò là producer) gửi các messages (records) tới một node kafka (broker) và nói rằng những messages này sẽ được xử lý bởi các ứng dụng khác gọi là consumers. 
Các messages được gửi tới kafka node sẽ được lưu trữ trong một nơi gọi là topic và sau đó consumer có thể subcribe tới topic đó và lắng nghe những messages này. 
Messages có thể là bất cứ thông tin gì như giá trị cảm biến, hành động người dùng, …  
### Tạo hàng đợi
![image](https://github.com/HuyPham01/docs/assets/96679595/9b30895d-bd04-4827-a09e-a7f7c8fbfba4)  
### Xuất bản-Đăng ký
![image](https://github.com/HuyPham01/docs/assets/96679595/432e3b5c-475d-498a-9806-204825b2ebad)  

# Cách tiếp cận của Kafka mang lại những lợi ích gì?
### Có khả năng mở rộng
Mô hình bản ghi phân vùng của Kafka cho phép dữ liệu được phân phối trên nhiều máy chủ, giúp dữ liệu có thể mở rộng vượt quá những gì phù hợp với một máy chủ duy nhất. 

### Nhanh
Kafka tách các luồng dữ liệu nên có độ trễ rất thấp, làm cho luồng trở nên cực kỳ nhanh. 

### Độ bền cao
Phân vùng được phân phối và sao chép trên nhiều máy chủ và dữ liệu được ghi vào đĩa. Điều này giúp bảo vệ khỏi lỗi máy chủ, giúp dữ liệu có dung sai rất cao và rất bền. 
