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
Khi tạo `VPC and more` và đây là mô hình kết nối:  VPC đước kết nối đến subnet, route table and internet gateway (network connections).
![image](https://github.com/HuyPham01/docs/assets/96679595/9d63806a-8bd5-4a7a-a091-23bc1df97a5a)  
Thiết lập `NAT gateway` để các instances private có thể kết nối ra bên ngoài. Nhưng từ bên ngoài thì không thể kết nối đến các instance đó.  
Trong khi điểm cuối VPC được kết nối với các dịch vụ do AWS PrivateLink cung cấp, bao gồm nhiều dịch vụ AWS. Nhấp vào `Create VPC`  
![image](https://github.com/HuyPham01/docs/assets/96679595/4b90efd5-33f5-4c01-930d-77e00a1a571b)  
![image](https://github.com/HuyPham01/docs/assets/96679595/af9f8d12-491e-4baa-ab26-ffd3f4aef3b2)  
click view vpc, click the Subnet section. subnet in VPC có nghĩa là range of IP addresses in VPC. Có 3 loại subnet:  
1. Public subnet:  có thể kết nối Internet bằng gateway or egress-only internet gateway.
2. Private subnet:  không kết nối Internet, nhưng muốn có thể kêt nối qua NAT gateway.
3. VPN-only subnet: needs a Site-to-Site VPN connection with a virtual private gateway.
Click filter subnets based on VPC values. Có thể dùng cách nay để xem các subnet trên vpc. Và có thể tạo thêm subnet.
![image](https://github.com/HuyPham01/docs/assets/96679595/4f348b6f-6681-4b09-b5e2-dc669b621834)
Click subnet ID budionosan-vpc-subnet-public1-us-west-1a.
![image](https://github.com/HuyPham01/docs/assets/96679595/e86278fb-3ab6-45d0-b1cb-230fef7799da)  
The public subnet has 2 routes, 1 local và internet gateway để connect ra internet
![image](https://github.com/HuyPham01/docs/assets/96679595/e8a8c815-c9c1-4bef-b74e-ace7e2ac1ac3)
Click subnet ID budionosan-vpc-subnet-private1-us-west-1a.
![image](https://github.com/HuyPham01/docs/assets/96679595/c88107cd-f071-432e-9dd1-6a0f968fad05)  
The private subnet has one route, because private subnet cannot connect internet. Private subnet recommended for databases. Có thể connect internet qua NAT gateway  
![image](https://github.com/HuyPham01/docs/assets/96679595/45f42c49-01e3-4b5e-a656-e6631bdae678)  
click `Route Tables`. Trong một VPC để điều hướng các traffic ra và vào, AWS sử dụng một phần mềm gọi là implied router. Router này sẽ dựa theo các rule được định nghĩa trong trong route table để điều hướng các traffic bên trong VPC. Mặc định khi tạo VPC, AWS sẽ tạo sẵn một route table cho VPC gọi là main route table và một khi ta tạo một subnet trong VPC, subnet này sẽ tự động được gắn vào main route table, nếu không muốn sử dụng main route table cho subnet, ta có thể tạo một custom route table rồi gắn subnet vào đó. Một subnet phải được gắn vào một route table.  
  
Một rule trong route table gọi là route, một route table có thể chứa một hoặc nhiều route. Các route xác định cách điều hướng các luồng traffic của các instance bên trong subnet được gắn với route table đó. Một route sẽ có hai giá trị sau:  
   
- Destination: là một dãy IP, các instance có địa chỉ IP nằm trong khoảng này có thể truy cập đến điểm đến là giá trị của target.  
- Target: là các tài nguyên network trong AWS như instance, internet gateway...
  
Một public subnet (tất cả các instance trong subnet đó có thể truy cập internet và ngược lại) là subnet được gắn vào route table có Destination là tập cha của dãy IP của subnet và Target là một internet gateway. Trong mỗi route table sẽ có một route mặc định với Target là local gọi là local route, route này giúp các instances trong cùng subnet có thể giao tiếp với nhau và có thể giao tiếp với các instance trong subnet khác trong cùng một VPC.  
![image](https://github.com/HuyPham01/docs/assets/96679595/f9720d32-6c46-4ed7-9123-dc943bd5b7e6)   
`Internet gateway`  VPC bị cô lập khỏi internet, vậy thì làm sao các thành phần trong VPC như các instances có thể truy cập internet hay từ internet có thể truy cập vào các instances trong VPC? đó chính là nhờ Internet Gateways. Nó cung cấp cho các instance khả năng nhận địa chỉ IP public, kết nối với Internet và nhận các requests từ Internet. Khi bạn tạo VPC, VPC không có Internet Gateway được liên kết với nó. Bạn phải tạo Internet Gateway và gắn nó với VPC theo cách thủ công.  
![image](https://github.com/HuyPham01/docs/assets/96679595/0ff92f83-28ae-4a9e-b06a-53cb1ed1aad7)  
## Security 
Vào `Security`. Click security group.Security group kiểm xoát traffic in và out trong vpc.  
![image](https://github.com/HuyPham01/docs/assets/96679595/20d088c3-7154-425c-9d13-b0475b72d52c)  
 click filter security group dựa trên vpc. Có thể tạo nhóm mới. Click security group ID sg-066…  
 ![image](https://github.com/HuyPham01/docs/assets/96679595/2e14d56f-53c6-4aaa-9f41-0b8b3b0def92)  
 security group được kết nối với VPC (name budionosan-vpc). Có các quy tắc ở đây `inbound rule` và `outbound rule`. Cuộn xuống để xem các `inbound rule` và nhấp vào chỉnh sửa `inbound rule`.  
 ![image](https://github.com/HuyPham01/docs/assets/96679595/e1b6ecf8-8f4e-4aab-bff5-ec83f6088d3b)  
 ![image](https://github.com/HuyPham01/docs/assets/96679595/0b3f3a82-d9c9-4b2d-ab87-9735baddd562)  
 ![image](https://github.com/HuyPham01/docs/assets/96679595/9b48bbb8-c227-4791-b959-b315ef162ffb)  
 Nếu muốn thêm rule có thể nhấn vào Add rule. Chọn một loại như Tất cả lưu lượng truy cập, TCP, UDP, IPv4, IPv6, SSH, DNS, HTTP, HTTPS, MySQL, Redshift, PostgreSQL và nhiều loại khác.  Input source address xong, hãy nhấp click save rules. Outbound rules giống như inbound rules.   
 ![image](https://github.com/HuyPham01/docs/assets/96679595/414226c9-36cd-41fd-ae31-68804cde7c56)  






 








