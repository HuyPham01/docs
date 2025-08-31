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