# Mục tiêu: Kết hợp tất cả các lỗi để RCE server

# Lab
Vì đã có tools ở lv2 nên ta có biết `cms` có trức năng upload file.  
Nhưng khi up load shell lên thì chỉ coi là text --> ko chạy được.
* biết trên 1 host có 2 site.  
dúng `/tools.php` cmli `&ls ..` -> 2 site `lamp,shop-cuties`
Vậy nếu ta upload file sáng bên `shop-cuties` thì sao. --> `../../shop-cuties/shell.php` có vẻ hợp lý
- để playload ở file `filename` nhưng ko hoạt động ko thoát ra được uploal.
- để playload xuống phần date -->done.  
<img src='./img/Screenshot 2025-07-29 at 23.25.20.png'>

Dùng `/tools.php` đã thấy nhận h chỉ cẩn sang `shop.xxx.xx/huy1234.php`