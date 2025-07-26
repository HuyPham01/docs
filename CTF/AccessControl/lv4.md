# 4. Level 4: – Goal: đọc được post private của user khác
# Cách hoạt động
Có vẻ giống lv3.  
nhưng khi thay `post_id` thì ko hoạt động.
<img src='./img/Screenshot 2025-07-26 at 23.03.03.png'>
Có anh dev đã rút kinh nghiệm và sửa nó. Mang code ra xem anh ta sửa ở đâu :).
<img src='./img/Screenshot 2025-07-26 at 23.06.11.png'>

Ở dòng 24-27 ở đây thấy có 3 điều kiện.:
- `post_id` = `$_GET['id']`
- `public = 1 OR author_id = $user_id` (ở đây nếu không phải là public thì cần sét đến `author_id`)
# Ý tưởng
ở dòng 7 - 9 ta thấy:
- dòng 7 `$user_id` = `$_SESSION['user_id']` (không thao túng được vì đâu có user/pass của user đó)
- dòng 8-9 ở đây lại kiểm tra xem nếu `user_id` được truyền vào thì `$user_id = $_GET['user_id'];` --> untrusted data.

# Khai thác.
Đúng như dự đón khi thêm param ẩn `&user_id=2` đã thành công.
<img src='./img/Screenshot 2025-07-26 at 23.17.16.png'>

