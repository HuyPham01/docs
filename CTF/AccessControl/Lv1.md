# I. Lab overview
- Đây là ứng dụng cho phép đăng post dưới 2 trạng thái: public và private. Để sử dụng, người dùng cần phải tạo tài khoản và đăng nhập.  
- Tại trang chủ /wall.php, người dùng có thế tạo post.
<img src="./img/Screenshot 2025-07-26 at 21.20.03.png">

# Analysis
## 1. Level 1 – Goal: đọc được post private của user khác
Ở Burp Suite ta thấy các gói tin như:
- login
- list posts
- read posts
- create posts
<img src="./img/Screenshot 2025-07-26 at 21.25.28.png">

Có 2 tham số ở `create content`:  
- `content`: nội dung.
- `public`: 0 == private, 1 == public.

Mở code ra xem
<img src="./img/Screenshot 2025-07-26 at 21.31.42.png">

Ở đây ta thấy `action = read` thì thực hiến truy vấn đến database để lấy content của post dựa vào `post_id`.  
Mà `post_id` lại được lấy từ `$_GET['id']` mà không có bất kì validate nào --> untrusted là `$_GET['id']`
### Ý tưởng
- Liệu ta có thể đọc được các post của người dùng khác bằng cách đổi `post_id`
### Khai thác
Trong lúc nhập `post_id` từ 0 ->3.  
Ta thấy ở `id` =3 thì đã đọc được content private của id 3.
<img src='./img/Screenshot 2025-07-26 at 21.41.40.png'>