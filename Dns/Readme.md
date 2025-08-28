# Sử dụng Docker-Compose để dễ dàng xây dựng giải pháp đầy đủ của PowerDNS và PowerDNS-Admin
Sử dụng powerdns để xây dựng DNS nội bộ. 
| Imges   |      Verions      |
|----------|:-------------:|
| mysql |  5.7.35 |
| powerdns/pdns-auth-47 |    4.7.4   |
| powerdnsadmin/pda-legacy | latest |
# Cài đặt
```
./docker-compose .yml
./pdns/config/pdns.conf
./pdnsdb/init-scripts/init.sql
```
vim ./pdnsdb/init-scripts/init.sql
```sql
use pdns;
CREATE TABLE domains (
  id                    INT AUTO_INCREMENT,
  name                  VARCHAR(255) NOT NULL,
  master                VARCHAR(128) DEFAULT NULL,
  last_check            INT DEFAULT NULL,
  type                  VARCHAR(8) NOT NULL,
  notified_serial       INT UNSIGNED DEFAULT NULL,
  account               VARCHAR(40) CHARACTER SET 'utf8' DEFAULT NULL,
  options               VARCHAR(64000) DEFAULT NULL,
  catalog               VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'latin1';
CREATE UNIQUE INDEX name_index ON domains(name);
CREATE INDEX catalog_idx ON domains(catalog);
CREATE TABLE records (
  id                    BIGINT AUTO_INCREMENT,
  domain_id             INT DEFAULT NULL,
  name                  VARCHAR(255) DEFAULT NULL,
  type                  VARCHAR(10) DEFAULT NULL,
  content               VARCHAR(64000) DEFAULT NULL,
  ttl                   INT DEFAULT NULL,
  prio                  INT DEFAULT NULL,
  disabled              TINYINT(1) DEFAULT 0,
  ordername             VARCHAR(255) BINARY DEFAULT NULL,
  auth                  TINYINT(1) DEFAULT 1,
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'latin1';
CREATE INDEX nametype_index ON records(name,type);
CREATE INDEX domain_id ON records(domain_id);
CREATE INDEX ordername ON records (ordername);
CREATE TABLE supermasters (
  ip                    VARCHAR(64) NOT NULL,
  nameserver            VARCHAR(255) NOT NULL,
  account               VARCHAR(40) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (ip, nameserver)
) Engine=InnoDB CHARACTER SET 'latin1';
CREATE TABLE comments (
  id                    INT AUTO_INCREMENT,
  domain_id             INT NOT NULL,
  name                  VARCHAR(255) NOT NULL,
  type                  VARCHAR(10) NOT NULL,
  modified_at           INT NOT NULL,
  account               VARCHAR(40) CHARACTER SET 'utf8' DEFAULT NULL,
  comment               TEXT CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'latin1';
CREATE INDEX comments_name_type_idx ON comments (name, type);
CREATE INDEX comments_order_idx ON comments (domain_id, modified_at);
CREATE TABLE domainmetadata (
  id                    INT AUTO_INCREMENT,
  domain_id             INT NOT NULL,
  kind                  VARCHAR(32),
  content               TEXT,
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'latin1';
CREATE INDEX domainmetadata_idx ON domainmetadata (domain_id, kind);
CREATE TABLE cryptokeys (
  id                    INT AUTO_INCREMENT,
  domain_id             INT NOT NULL,
  flags                 INT NOT NULL,
  active                BOOL,
  published             BOOL DEFAULT 1,
  content               TEXT,
  PRIMARY KEY(id)
) Engine=InnoDB CHARACTER SET 'latin1';

CREATE INDEX domainidindex ON cryptokeys(domain_id);
CREATE TABLE tsigkeys (
  id                    INT AUTO_INCREMENT,
  name                  VARCHAR(255),
  algorithm             VARCHAR(50),
  secret                VARCHAR(255),
  PRIMARY KEY (id)
) Engine=InnoDB CHARACTER SET 'latin1';
CREATE UNIQUE INDEX namealgoindex ON tsigkeys(name, algorithm);
```
vim ./pdns/config/pdns.conf
```conf
api=yes
api-key=qwerasdf
launch=gmysql
gmysql-host=pdnsdb
gmysql-port=3306
gmysql-dbname=pdns
gmysql-user=pdns
gmysql-password=pdns123
local-address=0.0.0.0
local-port=53  
webserver=yes
webserver-address=0.0.0.0
webserver-allow-from=0.0.0.0/0
webserver-port=8081
enable-lua-records=yes
```
vim ./docker-compose.yml
```yml
version: '3'
services:
  pdnsdb:
    image: mysql:5.7.35
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 123456
      MYSQL_DATABASE: pdns
      MYSQL_USER: pdns
      MYSQL_PASSWORD: pdns123
    volumes:
      - ./pdnsdb/data:/var/lib/mysql
      - ./pdnsdb/init-scripts:/docker-entrypoint-initdb.d
    networks:
      - pdns_net
  pdns:
    image: powerdns/pdns-auth-47:4.7.4
    restart: always
    user: root
    privileged: true
    environment:
      SECRET_KEY: qwerasdf
    ports:
      - "53:53/tcp"
      - "53:53/udp"
    volumes:
      - ./pdns/config:/etc/powerdns
    depends_on:
      - pdnsdb
    networks:
      - pdns_net
  pdnsadmindb:
    image: mysql:5.7.35
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 123456
      MYSQL_DATABASE: pdnsadmin
      MYSQL_USER: pdnsadmin
      MYSQL_PASSWORD: pdnsadmin123
    volumes:
      - ./pdnsadmindb/data:/var/lib/mysql
    networks:
      - pdns_net
  pdnsadmin:
    image: powerdnsadmin/pda-legacy:latest
    restart: always
    ports:
      - "9191:80"
    environment:
      - SQLALCHEMY_DATABASE_URI=mysql://pdnsadmin:pdnsadmin123@pdnsadmindb/pdnsadmin
      - GUNICORN_TIMEOUT=60
      - GUNICORN_WORKERS=2
      - GUNICORN_LOGLEVEL=DEBUG
    depends_on:
      - pdns
      - pdnsadmindb
    networks:
      - pdns_net
networks:
  pdns_net:
    driver: bridge
```
# Run
```bash
docker compose up -d
``` 
# Sử dụng PowerDnsAdmin
http://ip:9191
#  Đăng nhập thành công, cấu hình
apikey: xem `docker-compose.yml` SECRET_KEY: `qwerasdf`
![alt text](image.png)
