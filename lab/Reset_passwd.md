# Đặt lại pass Ubuntu
Để đặt lai password khi quên, khởi đông Ubuntu vào chế độ khôi phục `(Recovery Mode)`, chọn `Root shell prompt` (lời nhắc root shell)  
và thiết lập new password.  
Trước tiên, hãy khởi động lại server. Sau màn hình BIOS, có khởi động GRUB, nhấn `Shift` hoặc `Esc`  
![image](https://github.com/HuyPham01/docs/assets/96679595/edd4f0a1-ab8d-4392-80e2-eaf5704553eb)  
  
![image](https://github.com/HuyPham01/docs/assets/96679595/7695a6fd-be04-46ce-9f03-20b9b836fd5d)  

Trước tiên hãy gắn kết lại bộ nhớ với quyền ghi (write permissions):
```
mount -o remount,rw /
```
New passwd
```
passwd Username
```
Khi có thông báo `Successfully` thì đã thành công, hãy khởi động lại server bằng CLI `reboot`
