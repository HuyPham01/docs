# Mục tiêu: Tìm cách leak source code
# Lab 
Sử dụng tools để thăm dò
```
nuclei -u http://shop.xxx.com
```
Phát hiện path `.git/config`.  
Vào thử thì thấy có 1 url git public, lướt qua thì có phát hiện user admin trong đó :).
<img src='./img/Screenshot 2025-07-29 at 21.48.03.png'>

Giời thì qua lại vào trang login xem sao:  
login thành công vào có được flag
<img src='./img/Screenshot 2025-07-29 at 21.49.18.png'>
