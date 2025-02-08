#!/bin/sh

chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql

chown -R mysql:mysql /run/mysqld
chmod -R 755 /run/mysqld

mysql_install_db > /dev/null

tmp=$(mktemp)
if [ ! -f "$tmp" ]; then
	return 1
fi
cat << EOF > $tmp
	USE mysql;
	FLUSH PRIVILEGES;

	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

	CREATE DATABASE $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
	CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';

	FLUSH PRIVILEGES;
EOF
mysqld --user=mysql --bootstrap < $tmp

exec mysqld --console