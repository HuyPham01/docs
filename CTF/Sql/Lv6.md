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
# Khai thác.
