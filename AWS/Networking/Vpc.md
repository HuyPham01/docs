# Networking on AWS — Amazon Virtual Private Cloud (VPC)
Go to Networking & Content Delivery section and click VPC. Click Create VPC. Mỗi region maximal 5 VPC only.  
`VPC only` nghĩ chỉ tạo VPC only mà không tạo  subnet, internet gateway and route table.  
`VPC and more` sẽ tự động tạo subnet, internet gateway and route table.  
## create VPC and more.
![image](https://github.com/HuyPham01/docs/assets/96679595/4fb0009f-19ec-4250-9059-b6e3081ac1dd)  
`IPv4 CIDR block`(classless inter domain routing)  
Khi tạo VPC, ta phải tạo cho nó ít nhất một dãy địa chỉ IP, VPC sẽ tự động cấp phát cho các instance bên trong nó địa chỉ IP nằm trong dãy IP này. Một dãy địa chỉ IP có thể được biểu diễn bằng nhiều dạng, nhưng AWS sử dụng dạng khổi CIDR để biểu diễn dãy địa chỉ IP. Dãy địa chỉ IP trong CIDR có dạng như sau 172.16.32.0/20 (172.16.32.0 - 172.16.47.255). trong đó /20 thể hiện độ dài tiền tố hay số bit bị chiếm dụng bời tiền tố, do đó con số này càng nhỏ thì dãy IP này càng chứa nhiều địa chỉ IP. Trong VPC, độ dài tiền tố hợp lệ trong khoảng từ /16 đến /28 (/28 chỉ có 16 địa chỉ IP).  
Mặc dù ta có thể tạo bất kỳ dãy ip nào cho VPC miễn là nó hợp lệ, tuy nhiên AWS khuyến cáo nên sử dụng IP range theo chuẩn RFC 1918 để tránh xung đột với IP public  
- 10.0.0.0–10.255.255.255 (10.0.0.0/8)  
- 172.16.0.0–172.31.255.255 (172.16.0.0/12)  
- 192.168.0.0–192.168.255.255 (192.168.0.0/16)
  
`Availability Zones (AZ)` là số zone trong 1 region.  
![image](https://github.com/HuyPham01/docs/assets/96679595/73e90e8e-b901-4682-9028-a3ebe9631605)  
`Subnet` là một logic container bên trong VPC nơi mà ta sẽ đặt các instance, có tác dụng cô lập một số instance khỏi các instance khác ngay trong chính VPC. Có thể hiểu rằng VPC là một căn nhà thì các subnet chính là các căn phòng bên trong ngôi nhà đó, mục đích để giúp ta có thể nhóm các instance lại theo mặt chức năng. Ví dụ: Trong một VPC có các server và database, các server sẽ được public ra ngoài internet thì ta sẽ đặt nó bên trong public subnet, còn các database không được phép public ra ngoài internet mà chỉ được truy cập bởi các server thì ta sẽ đặt nó trong private subnet. Khi tạo một AWS instance thì bắt buộc phải chọn subnet cho nó, một subnet có thể chứa nhiều instance và một instance chỉ thuộc một subnet và một khi đã gắn một instance vào một subnet thì ta không thể chuyển nó sang subnet khác, chỉ có thể xóa instance đó và tạo lại ở subnet khác.  
`Subnet CIDR Blocks`  Giống như VPC, subnet cũng có dãy IP(CIDR Block) của riêng mình, dãy IP này phải là tập con của dãy IP của VPC, vd: VPC có dãy IP là 172.16.0.0/16 (172.16.0.0 - 172.16.255.255) thì ta có thể chọn CIDR block cho sunnet là 172.16.100.0/16 (172.16.0.0 - 172.16.255.255). Đối với mỗi subnet, AWS sẽ lấy 4 địa chỉ đầu và một địa chỉ cuối cùng của dãy IP trong subnet cho mục đích nào đó mình chưa biết :v , vì thế ta sẽ không thể dùng các địa chỉ này để assign cho các instance bên trong subnet đó. vd: subnet A có CIDR block là 172.16.100.0/16 (172.16.0.0 - 172.16.255.255) thì các địa chỉ sau sẽ không sử dụng được:  
172.16.100.0–172.16.100.3  
172.16.100.255  
Trong một zone sẽ có 1 public subnet và 1,2,3...private subnet  
![image](https://github.com/HuyPham01/docs/assets/96679595/45ff4ea0-a628-406a-879d-a671fccf0727)  

