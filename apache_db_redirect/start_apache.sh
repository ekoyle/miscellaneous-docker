#!/bin/bash

. /etc/apache2/envvars

mkdir -p /var/lock/apache2
mkdir -p /var/run/apache2

cat << EOF > /etc/apache2/sites-available/000-default.conf
# Do the stuff
DBDriver pgsql
DBDParams "${DB_CONNSTR:-dbname=redirect_test}"

<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html

	#ErrorLog \${APACHE_LOG_DIR}/error.log
	#CustomLog \${APACHE_LOG_DIR}/access.log combined

	RewriteEngine On
	RewriteMap host_redir "dbd:SELECT tourl FROM host_redir WHERE fromhost = %s"
	RewriteRule . "\${host_redir:%{HTTP_HOST}|${REDIR_FAILURE_BASE:-http://redirfailure.usu.edu}/host=%{HTTP_HOST}}" [R=302,L]

</VirtualHost>

EOF

exec /usr/sbin/apache2 -D FOREGROUND

