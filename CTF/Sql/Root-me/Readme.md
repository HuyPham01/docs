## [SQL injection - Authentication](https://www.root-me.org/en/Challenges/Web-Server/SQL-injection-Authentication)
### Steps to reproduce

  - Start the challenge
  - Go to the login page
  - Use the following payloads to bypass authentication:
    - Username: `admin' -- `
    - Password: `admin` 
    - Click on the "Login" button
  - Đăng nhập thành công với tư cách là quản trị viên
  - To validate the challenge use this password --> password = 'admin' --> error
  - Ctrl + U để xem source code
  - Tìm thấy password `value` trong source code
  - Submit the password to complete the challenge.

## [SQL injection - Strings](https://www.root-me.org/en/Challenges/Web-Server/SQL-injection-Strings)
### Steps to reproduce
- Start the challenge
- Bài này cho ta nhiều lựa chọn hơn, ta có các chức năng như đăng nhập, tìm kiếm hay xem thông tin
- Tuy nhiên lỗi sqli xuất hiện tại ô tìm kiếm. 
- Để biết được tại sao lại bị lỗi sqli ta chỉ cần nhập vào ký tự `1'` . Lỗi sẽ xuất hiện Và biết đây là `sqlite3`
- Để khai thác lỗi sqli ta có thể sử dụng payload sau: `1' UNION SELECT sql, null FROM sqlite_master--`
- Ta sẽ thấy được các bảng trong database
- Tiếp theo ta sẽ lấy dữ liệu từ bảng `users` với payload sau: `1' UNION SELECT username,password FROM users--`
- Ta sẽ thấy được username và password của các user trong bảng users
- Submit password của user admin để hoàn thành challenge

## [SQL injection - Numeric](https://www.root-me.org/en/Challenges/Web-Server/SQL-injection-Numeric)
### Steps to reproduce
- Start the challenge
- Bài này ta có thể thấy lỗi sqli xuất hiện tại tham số id trong url `action=new&new_id=1`
- Để biết được tại sao lại bị lỗi sqli ta chỉ cần nhập vào ký tự `1'` . Lỗi sẽ xuất hiện Và biết đây là `sqlite3`
- Để khai thác lỗi sqli ta có thể sử dụng payload sau: `1 UNION SELECT null,sql, null FROM sqlite_master--`
- Ta sẽ thấy được các bảng trong database
- Tiếp theo ta sẽ lấy dữ liệu từ bảng `users` với payload sau: `1 UNION SELECT null,username,password FROM users--`
- Ta sẽ thấy được username và password của các user trong bảng users
- Submit password của user admin để hoàn thành challenge.