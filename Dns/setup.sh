#!/bin/bash

echo "================================================="
echo "   Auto-Setup PowerDNS & PowerDNS-Admin (GSLB)   "
echo "================================================="
echo ""

# Cấu hình Mặc định / Prompt từ user
read -p "Enter MySQL Root Password [123456]: " MYSQL_ROOT_PASSWORD
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-123456}

read -p "Enter PowerDNS DB Password [pdns123]: " MYSQL_PASSWORD
MYSQL_PASSWORD=${MYSQL_PASSWORD:-pdns123}

read -p "Enter PowerDNS-Admin DB Password [pdnsadmin123]: " PDNSADMIN_PASSWORD
PDNSADMIN_PASSWORD=${PDNSADMIN_PASSWORD:-pdnsadmin123}

read -p "Enter API Key for PowerDNS [qwerasdf]: " PDNS_API_KEY
PDNS_API_KEY=${PDNS_API_KEY:-qwerasdf}

read -p "Enter Default SOA Content [ns1.evg.vn admin.evg.vn 0 10800 3600 604800 3600]: " SOA_CONTENT
SOA_CONTENT=${SOA_CONTENT:-ns1.evg.vn admin.evg.vn 0 10800 3600 604800 3600}

echo ""
echo "[+] Creating directories..."
mkdir -p powerdns/pdns/config
mkdir -p powerdns/pdnsdb/init-scripts
mkdir -p powerdns/pdnsdb/data

cd powerdns

echo "[+] Generating .env file..."
cat <<EOF > .env
# Database Passwords
MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
MYSQL_PASSWORD=$MYSQL_PASSWORD
PDNSADMIN_PASSWORD=$PDNSADMIN_PASSWORD

# PowerDNS API
PDNS_API_KEY=$PDNS_API_KEY
EOF

echo "[+] Generating docker-compose.yml..."
cat <<'EOF' > docker-compose.yml
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
      PDNSADMIN_PASSWORD: ${PDNSADMIN_PASSWORD}
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
EOF

echo "[+] Generating pdns.conf..."
cat <<EOF > pdns/config/pdns.conf
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
default-soa-content=$SOA_CONTENT
expand-alias=yes
resolver=8.8.8.8
EOF

echo "[+] Generating database initialization scripts..."
cat <<'EOF' > pdnsdb/init-scripts/01-users.sh
#!/bin/bash
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
CREATE DATABASE IF NOT EXISTS pdnsadmin;
CREATE USER IF NOT EXISTS 'pdnsadmin'@'%' IDENTIFIED BY '${PDNSADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON pdnsadmin.* TO 'pdnsadmin'@'%';
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS pdns;
EOSQL
EOF
chmod +x pdnsdb/init-scripts/01-users.sh

cat <<'EOF' > pdnsdb/init-scripts/init.sql
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
EOF

echo ""
echo "================================================="
echo "Setup files created successfully in ./powerdns/ !"
echo "To start the system, run:"
echo "cd powerdns"
echo "docker compose up -d"
echo "================================================="
