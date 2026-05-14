# Triển khai PowerDNS và PowerDNS-Admin (Phiên bản Mới nhất)

Tài liệu này hướng dẫn sử dụng `docker-compose` để triển khai giải pháp PowerDNS và giao diện quản lý PowerDNS-Admin với các phiên bản mới nhất hiện nay.

| Components | Images | Versions |
|----------|:-------------:|:-------------:|
| Cơ sở dữ liệu | `mysql` | `8.0` |
| Máy chủ DNS | `powerdns/pdns-auth-50` | `latest` (5.0.x) |
| Giao diện Quản trị | `powerdnsadmin/pda-legacy` | `latest` |

## Cấu trúc thư mục cài đặt

Tạo thư mục dự án và các file cấu hình như sau:

```bash
mkdir -p pdns/config pdnsdb/init-scripts pdnsdb/data
```

Danh sách các file cần tạo:
- `.env`
- `docker-compose.yml`
- `pdns/config/pdns.conf`
- `pdnsdb/init-scripts/01-users.sh`
- `pdnsdb/init-scripts/init.sql`

---

## 1. Khởi tạo Biến Môi Trường (`.env`)
Tạo file `.env` ngang hàng với `docker-compose.yml` để bảo mật thông tin:

```env
# Database Passwords
MYSQL_ROOT_PASSWORD=123456
MYSQL_PASSWORD=pdns123
PDNSADMIN_PASSWORD=pdnsadmin123

# PowerDNS API
PDNS_API_KEY=qwerasdf
```

---

## 2. Khởi tạo Database Schema (`01-users.sh` và `init.sql`)

Do chúng ta dùng biến môi trường, ta cần 1 script bash để tạo Database và 1 file SQL để tạo bảng.

**File 1: `pdnsdb/init-scripts/01-users.sh`**
```bash
#!/bin/bash
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
CREATE DATABASE IF NOT EXISTS pdnsadmin;
CREATE USER IF NOT EXISTS 'pdnsadmin'@'%' IDENTIFIED BY '${PDNSADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON pdnsadmin.* TO 'pdnsadmin'@'%';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS pdns;
EOSQL
```
*(Lưu ý: Chạy lệnh `chmod +x pdnsdb/init-scripts/01-users.sh` để cấp quyền thực thi).*

**File 2: `pdnsdb/init-scripts/init.sql`**
```sql
USE pdns;

CREATE TABLE domains (
  id                    INT AUTO_INCREMENT,
  name                  VARCHAR(255) NOT NULL,
  master                VARCHAR(128) DEFAULT NULL,
  last_check            INT DEFAULT NULL,
  type                  VARCHAR(8) NOT NULL,
  notified_serial       INT UNSIGNED DEFAULT NULL,
  account               VARCHAR(40) CHARACTER SET 'utf8mb4' DEFAULT NULL,
  options               TEXT DEFAULT NULL,
  catalog               VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

CREATE UNIQUE INDEX name_index ON domains(name);
CREATE INDEX catalog_idx ON domains(catalog);

CREATE TABLE records (
  id                    BIGINT AUTO_INCREMENT,
  domain_id             INT DEFAULT NULL,
  name                  VARCHAR(255) DEFAULT NULL,
  type                  VARCHAR(10) DEFAULT NULL,
  content               TEXT DEFAULT NULL,
  ttl                   INT DEFAULT NULL,
  prio                  INT DEFAULT NULL,
  disabled              TINYINT(1) DEFAULT 0,
  ordername             VARCHAR(255) BINARY DEFAULT NULL,
  auth                  TINYINT(1) DEFAULT 1,
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

CREATE INDEX nametype_index ON records(name,type);
CREATE INDEX domain_id ON records(domain_id);
CREATE INDEX ordername ON records (ordername);

CREATE TABLE supermasters (
  ip                    VARCHAR(64) NOT NULL,
  nameserver            VARCHAR(255) NOT NULL,
  account               VARCHAR(40) CHARACTER SET 'utf8mb4' NOT NULL,
  PRIMARY KEY (ip, nameserver)
) Engine=InnoDB CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

CREATE TABLE comments (
  id                    INT AUTO_INCREMENT,
  domain_id             INT NOT NULL,
  name                  VARCHAR(255) NOT NULL,
  type                  VARCHAR(10) NOT NULL,
  modified_at           INT NOT NULL,
  account               VARCHAR(40) CHARACTER SET 'utf8mb4' DEFAULT NULL,
  comment               TEXT CHARACTER SET 'utf8mb4' NOT NULL,
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

CREATE INDEX comments_name_type_idx ON comments (name, type);
CREATE INDEX comments_order_idx ON comments (domain_id, modified_at);

CREATE TABLE domainmetadata (
  id                    INT AUTO_INCREMENT,
  domain_id             INT NOT NULL,
  kind                  VARCHAR(32),
  content               TEXT,
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

CREATE INDEX domainmetadata_idx ON domainmetadata (domain_id, kind);

CREATE TABLE cryptokeys (
  id                    INT AUTO_INCREMENT,
  domain_id             INT NOT NULL,
  flags                 INT NOT NULL,
  active                BOOL,
  published             BOOL DEFAULT 1,
  content               TEXT,
  PRIMARY KEY(id)
) Engine=InnoDB CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

CREATE INDEX domainidindex ON cryptokeys(domain_id);

CREATE TABLE tsigkeys (
  id                    INT AUTO_INCREMENT,
  name                  VARCHAR(255),
  algorithm             VARCHAR(50),
  secret                VARCHAR(255),
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

CREATE UNIQUE INDEX namealgoindex ON tsigkeys(name, algorithm);
```

---

## 3. Cấu hình PowerDNS (`pdns.conf`)

Tạo file `pdns/config/pdns.conf`. Lưu ý có `expand-env=yes` để nó đọc biến từ `.env`:

```conf
api=yes
api-key=$PDNS_API_KEY
launch=gmysql
gmysql-host=pdnsdb
gmysql-port=3306
gmysql-dbname=pdns
gmysql-user=pdns
gmysql-password=$MYSQL_PASSWORD
local-address=0.0.0.0
local-port=53  
webserver=yes
webserver-address=0.0.0.0
webserver-allow-from=0.0.0.0/0,::/0
webserver-port=8081

# Advanced Features
enable-lua-records=yes
gmysql-dnssec=yes
default-soa-content=ns1.evg.vn admin.evg.vn 0 10800 3600 604800 3600
expand-alias=yes
resolver=8.8.8.8
expand-env=yes
```

---

## 4. Cấu hình Docker Compose (`docker-compose.yml`)

Tạo file `docker-compose.yml` với nội dung dưới đây:

```yml
version: '3.8'

services:
  pdnsdb:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: pdns
      MYSQL_USER: pdns
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - ./pdnsdb/data:/var/lib/mysql
      - ./pdnsdb/init-scripts:/docker-entrypoint-initdb.d
    networks:
      - pdns_net

  pdns:
    image: powerdns/pdns-auth-50:latest
    restart: always
    user: root
    privileged: true
    environment:
      SECRET_KEY: ${PDNS_API_KEY}
      PDNS_API_KEY: ${PDNS_API_KEY}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    ports:
      - "10053:53/tcp"
      - "10053:53/udp"
    volumes:
      - ./pdns/config:/etc/powerdns
    depends_on:
      - pdnsdb
    networks:
      - pdns_net

  pdnsadmin:
    image: powerdnsadmin/pda-legacy:latest
    restart: always
    ports:
      - "9191:80"
    environment:
      - SQLALCHEMY_DATABASE_URI=mysql://pdnsadmin:${PDNSADMIN_PASSWORD}@pdnsdb/pdnsadmin
      - GUNICORN_TIMEOUT=60
      - GUNICORN_WORKERS=2
      - GUNICORN_LOGLEVEL=INFO
      - PDNS_API_URL=http://pdns:8081/
      - PDNS_API_KEY=${PDNS_API_KEY}
      - PDNS_VERSION=5.0.4
    depends_on:
      - pdns
      - pdnsdb
    networks:
      - pdns_net

networks:
  pdns_net:
    driver: bridge
```

---

## 5. Chạy Hệ thống

Để khởi động toàn bộ hệ thống, chạy lệnh sau:

```bash
docker compose up -d
```

---

## 6. Sử dụng PowerDNS-Admin

- Truy cập giao diện quản trị tại: `http://<ip-may-chu>:9191`
- Trong lần truy cập đầu tiên, bấm **Create an account** để tạo tài khoản. Do đây là tài khoản đầu tiên nên nó sẽ tự động được cấp quyền Admin cao nhất.
- Sau khi đăng nhập, hệ thống đã được tự động kết nối qua biến môi trường, bạn có thể bắt đầu sử dụng ngay lập tức.

### Khắc phục Lỗi Ẩn Bản Ghi LUA
Mặc định PowerDNS-Admin ẩn bản ghi LUA khỏi giao diện. Để hiển thị, bạn cần chạy lệnh sau trên server để can thiệp vào DB, sau đó khởi động lại container Admin:

```bash
docker compose exec pdnsdb mysql -u pdnsadmin -ppdnsadmin123 pdnsadmin -e "UPDATE setting SET value = REPLACE(value, '\"LUA\": false', '\"LUA\": true') WHERE name='forward_records_allow_edit';"
docker compose restart pdnsadmin
```

---

## 7. Các Tính Năng Nâng Cao Đã Bật

1. **API Gốc PowerDNS:** 
   - Quản lý cực mạnh qua API `http://<IP>:8081/api/v1/` với header `X-API-Key: qwerasdf`.
2. **DNSSEC:**
   - Đã bật sẵn ở cấp độ máy chủ. Để kích hoạt bảo vệ cho 1 domain, dùng lệnh: `docker compose exec pdns pdnsutil secure-zone <domain>`
3. **ALIAS Records:**
   - Có thể thêm trực tiếp từ UI. Tự động mở rộng (resolve) thông qua DNS trung gian là 8.8.8.8.
4. **LUA Records & TCP Health Check:**
   - Dùng làm Load Balancing / Failover. 
   - Ví dụ cấu hình (Ghi vào ô Giá trị - Value của bản ghi LUA trên UI): `A "ifportup(80, {{'1.1.1.1'}, {'2.2.2.2'}})"`
