# 3. Level 3: – Goal: đọc được post private của user khác
## Cách hoạt động.
Ở level này, chúng ta có thể truy cập đến trang cá nhân của user đang online là admin và crush. Tuy nhiên ta chỉ có thể xem những post public của các user đó.
<img src='./img/Screenshot 2025-07-26 at 22.32.01.png'>

<img src='./img/Screenshot 2025-07-26 at 22.32.16.png'>

Kiểm tra Burp suite có gì ko 
<img src='./img/Screenshot 2025-07-26 at 22.42.32.png'>

Ở dòng 753 ta thấy `GET /post.php?action=list_posts&user_id=2` và có trả về 1 `post_id` nào đó .
<img src='./img/Screenshot 2025-07-26 at 22.45.23.png'>

Trong code ta thấy `action=list_posts` đang list hết các bài post của user đó dựa vào `user_id`.

## Ý tưởng.
giờ thay `post_id` tìm thấy từ user_id=2 thì có đọc được private không

## Kiểm chứng giả thiết

Như vậy chỉ vần sử dụng `post_id` mà đã biết của user_id 2 là có thể đọc được posts của họ.
<img src='./img/Screenshot 2025-07-26 at 22.57.16.png'>