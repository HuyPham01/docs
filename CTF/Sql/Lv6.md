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

🔁 Cách đổi chuỗi bất kỳ thành HEX:
Bạn có thể dùng lệnh trong terminal hoặc code PHP/Python:
```
echo -n 'posts' | xxd -p
```
Kết quả: `706f737473`

✅ Tại sao phải thêm 0x trong 0x706f737473?  
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
