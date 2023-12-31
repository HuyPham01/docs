# Keepalived configuration file

File cấu hình: `/etc/keepalived/keepalived.conf`

Một ví dụ đơn giản về hệ thống cân bằng tải gồm hai server: LB1 (active) và LB2 (backup) sẽ định tuyến các requests cho một pool của bốn web server chạy `httpd` với real IP là 192.168.1.20 tới 192.168.1.24, chia sẻ một virtual IP (VIP) là 10.0.0.1. Mỗi một lb có hai interfaces (eth0 và eth1), một sẽ thực hiện xử lý external internet traffic, hai sẽ thực hiện routing requests tới các server thực. Giải thuật load balancing được sử dụng là Round Robin và routing method sẽ là NAT.

## 1. Global Definitions

Global Definitions section cho phép admin chỉ định chi tiết thông báo khi có sự thay đổi xảy ra với load balancer. Section này là tùy chọn không yêu cầu bắt buộc trong cấu hình của keepalived. Section này giống nhau trên cả lb2 và lb1.

```sh
global_defs {

   notification_email {
       admin@example.com
   }
   notification_email_from noreply@example.com
   smtp_server 127.0.0.1
   smtp_connect_timeout 60
}
```

* `notification_email` là địa chỉ email của admin
* `notification_email_from` là địa chỉ gửi load balancer state changes. 

Cấu hình cụ thể của SMTP chỉ định máy chủ thư mà các thông báo được gửi mail qua.


## 2 . VRRP Instance

Ví dụ dưới đây là một đoạn `vrrp_sync_group` của file config `keeplalived.conf` trong master router và backup router. Chú ý về giá trị `state` và `priority` khác nhau giữ hai lb.

Ví dụ trên master:

```sh
vrrp_sync_group VG1 {
   group {
      RH_EXT
      RH_INT
   }
}

vrrp_instance RH_EXT {
    state MASTER
    interface eth0
    virtual_router_id 50
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass passw123
    }
    virtual_ipaddress {
    10.0.0.1
    }
}

vrrp_instance RH_INT {
   state MASTER
   interface eth1
   virtual_router_id 2
   priority 100
   advert_int 1
   authentication {
       auth_type PASS
       auth_pass passw123
   }
   virtual_ipaddress {
       192.168.1.1
   }
}
```

Ví dụ trên node backup:

```sh
vrrp_sync_group VG1 {
   group {
      RH_EXT
      RH_INT
   }
}

vrrp_instance RH_EXT {
    state BACKUP
    interface eth0
    virtual_router_id 50
    priority 99
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass passw123
    }
    virtual_ipaddress {
    10.0.0.1
    }
}

vrrp_instance RH_INT {
   state BACKUP
   interface eth1
   virtual_router_id 2
   priority 99
   advert_int 1
   authentication {
       auth_type PASS
       auth_pass passw123
   }
   virtual_ipaddress {
       192.168.1.1
   }
}
```

Trong ví dụ `vrrp_sync_group` định nghĩa một VRRP group. Nó có một instance được định nghĩa cho external interface để kết nối ra ngoài internet (RH_EXT), và một cho internal interface (RH_INT). 

* Dòng `vrrp_instance` cấu hình chi tiết các virtual interface cho VRRP service daemon, cái mà  được tạo bởi VIP instanece. `state MASTER` được thiết kế cho active server, và `state BACKUP` là cho backup server.

* `interface` là thuộc tính chỉ định tên physical interface để thêm VIP instance.

* `virtual_router_id` là một số dùng để định danh cho các virtual router instance. Nó sẽ giống nhau trên tất cả các LVS Router systems tham gia vào Virtual Router. Nó được sử dụng để phân biệt các instances của keepalived chạy trên cùng một network interface.

* `priority` chỉ định thứ tự, độ ưu tiên chọn các interface trong khi failover; số càng cao, mức độ ưu tiên càng cao. Giá trị ưu tiên này phải nằm trong khoảng từ 0 đến 255, và Load Balancing server được cấu hình như `state MASTER` nên có một giá trị priority được thiết lập cao hơn giá trị priority được thiết lập bên phía server được cấu hình `state BACKUP`.

* `authentication` block chỉ định authentication type (`auth_type`) và password (`auth_pass`) được sử dụng để xác thực server khi failover synchronization. `PASS` chỉ định password authentication; Keepalived cũng hỗ trợ AH hoặc Authentication Headers cho các kết nối toàn vẹn.

* `virtual_ipaddress` chỉ định một interface virtual IP address.


### 3. Virtual Server Definitions

Section định nghĩa Virtual Server giống nhau trên cả LB1 và LB2.

```sh
virtual_server 10.0.0.1 80 {
    delay_loop 6
    lb_algo rr
    lb_kind NAT
    protocol TCP

    real_server 192.168.1.20 80 {
        TCP_CHECK {
                connect_timeout 10
        }
    }
    real_server 192.168.1.21 80 {
        TCP_CHECK {
                connect_timeout 10
        }
    }
    real_server 192.168.1.22 80 {
        TCP_CHECK {
                connect_timeout 10
        }
    }
    real_server 192.168.1.23 80 {
        TCP_CHECK {
                connect_timeout 10
        }
    }

}
```

* Dòng đầu tiên `virtual_server` với IP address.
* `delay_loop`: Cấu hình khoảng thời gian (được tính bằng giây) giữa các lần health checks. 
* `lb_algo`: chỉ định loại giải thuật được sử dụng cho tính khả dụng (trong trường hợp này là `rr` hay round-robin)
* `lb_kind`: xác định routing method (trong ví dụ trên là sử dụng NAT)
* Sau đó là cấu hình chi tiết cho các Virtual Server
	* `real_server` được cấu hình lại một lần nữa, tương tự với IP được chỉ định lúc trước. 
	* `TCP_CHECK` Kiểm tra tính khả dụng của real server bằng cách sử dụng TCP. 
	* `connect_timeout` cấu hình thời gian tính bằng giây, trước khi một timeout xảy ra.

Bảng một số các giá trị `lv_algo` cho Virtual Server

|Algorithm Name	|lv_algo value|
|---|---|
|Round-Robin| rr|
|Weighted Round-Robin| wrr|
|Least-Connection| lc|
|Weighted Least-Connection| wlc|
|Locality-Based Least-Connection| lblc|
|Locality-Based Least-Connection Scheduling with Replication| lblcr|
|Destination Hash| dh|
|Source Hash| sh|
|Source Expected Delay| sed|
|Never Queue| nq|







## Tham khảo

[1] https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/load_balancer_administration/ch-initial-setup-vsa
