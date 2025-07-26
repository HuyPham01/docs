## 2 Level 2  – Goal: đọc được post private của user khác
### Cách hoạt động
Vẫn là các như lv1:
- login
- list posts
- read posts
- create posts
<img src="./img/Screenshot 2025-07-26 at 22.00.01.png">

Thì với lv2 thì ở phần `id` đã thay đổi băng 1 đoạn mà gì đó.  
Ở Burp Suite có tính nằng decode chỉ cần bôi đen.  
Thì ra là base64 
<img src='./img/Screenshot 2025-07-26 at 22.02.42.png'>

### Ý tưởng
Nếu đã biết là `base64` và id có dạng 6 số `000004` chỉ cần thay đổi từ `000001 - 999999` dưới dạng base64 thì có đọc được post của người khác.  
### Khai thác
Thật may khi mới đến `000003` -> `MDAwMDAz` thì đã thành công.
<img src='./img/Screenshot 2025-07-26 at 22.10.02.png'>