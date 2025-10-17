#!/bin/bash

# =========================================================
# CONFIGURATION VARIABLES
# =========================================================
# Change these to your actual strong passwords
ROOT_PASS="xxxx"
REPL_USER="repl_user"
REPL_PASS="xxxx"

# Replication host. '%' allows connection from any IP.
# Change to a specific IP (e.g., '192.168.1.100') for better security.
REPL_HOST="%"

# =========================================================
# 1. INSTALL MYSQL SERVER
# =========================================================
echo "-> Updating system packages and installing MySQL Server..."
sudo apt update -y
sudo apt install mysql-server -y

if [ $? -ne 0 ]; then
    echo "Error: Failed to install MySQL Server. Exiting."
    exit 1
fi

# =========================================================
# 2. CONFIGURE ROOT PASSWORD AND INITIAL SECURITY
# =========================================================
echo "-> Configuring root password and basic security settings..."

# Create a temporary SQL file to automate password setting and security
TEMP_SQL_FILE="/tmp/setup_mysql.sql"
cat << EOF > ${TEMP_SQL_FILE}
# Set password for the root account (for MySQL 8.0+)
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';

# Remove anonymous users
DELETE FROM mysql.user WHERE User='';

# Disallow remote root login
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

# Remove the 'test' database
DROP DATABASE IF EXISTS test;

# Reload privileges
FLUSH PRIVILEGES;
EOF

# Execute the temporary SQL file
# Use 'sudo mysql <' since the root user has 'auth_socket' authentication initially
sudo mysql < ${TEMP_SQL_FILE}
rm ${TEMP_SQL_FILE}

# Check if setting the root password was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to set the root password. Check the password complexity or MySQL logs."
    exit 1
fi


# =========================================================
# 3. CREATE REPLICATION USER
# =========================================================
echo "-> Creating replication user: ${REPL_USER}..."

# Execute SQL commands using the newly set root password
sudo mysql -u root -p"${ROOT_PASS}" -e "
CREATE USER '${REPL_USER}'@'${REPL_HOST}' IDENTIFIED BY '${REPL_PASS}';
GRANT REPLICATION SLAVE ON *.* TO '${REPL_USER}'@'${REPL_HOST}';
FLUSH PRIVILEGES;
"

# =========================================================
# 4. FINAL OUTPUT
# =========================================================
if [ $? -eq 0 ]; then
    echo "========================================================="
    echo "                 SETUP COMPLETE!"
    echo "========================================================="
    echo "MySQL has been installed and secured."
    echo "LOGIN DETAILS:"
    echo "  - Root User:        root"
    echo "  - Root Password:    ${ROOT_PASS}"
    echo "  - Replication User: ${REPL_USER}"
    echo "  - Replication Pass: ${REPL_PASS}"
    echo "  - Replication Host: ${REPL_HOST}"
    echo "========================================================="
else
    echo "Error: Failed to create the replication user. Check the MySQL logs for details."
fi
