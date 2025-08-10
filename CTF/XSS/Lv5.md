# HTML Injection 5

# Thử thách về lỗi bảo mật HTML Injection

# Mục tiêu: Đọc note của nạn nhân
# phân tích code:
```html
<!DOCTYPE html>
<html>

<head>
    <title>Quick Note 5</title>
    <style>
        body {
            padding: 50px;
            font: 14px "Lucida Grande", Helvetica, Arial, sans-serif;
        }

        input {
            margin-top: 5px;
            margin-bottom: 5px;
            display: inline-block;
            vertical-align: middle;
            margin-left: 20px
        }

        label {
            display: inline-block;
            padding-top: 5px;
            text-align: left;
            width: 100px;
        }
    </style>
</head>

<body>
    <h1>Quick Note 5</h1>
    <br>
    <p>Welcome <%= email %>! 👋</p>
    <form action="/note" method="post">
        <label>Note here:</label>
        <input type="text" name="note">
        <input type="submit" value="➕">
    </form>
    <br>
    <a href="/note">List note</a>
    <br>
    <br>
    <a href="/logout" onclick="clearInfo()">Logout</a>
    
    <script>
        function clearInfo() {
            localStorage.removeItem("info");
        }
    </script>

</body>

</html>
```
- Đoạn code trên là một trang HTML đơn giản cho phép người dùng nhập ghi chú và lưu chúng. Tuy nhiên, **việc sử dụng `<%= %>` để hiển thị email là an toàn**, vì EJS sẽ tự động escape các ký tự đặc biệt (như `<`, `>`, `&`, `"`, `'`). Điều này ngăn chặn việc chèn và thực thi mã HTML hoặc JavaScript độc hại, nên không.
- kích hoạt là sử dụng Protocol javascript thì sao.