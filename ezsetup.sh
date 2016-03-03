#!/bin/sh

# Configuration variables
TIMEZONE=Europe/Paris
MEMORY_LIMIT=256M
MAX_EXECUTION_TIME=180
XDEBUG_NESTING=10000

# Update repos
apt-get update

# Mysql
apt-get install -y mysql-server mysql-client
# Apache
apt-get install -y apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert
# Php
apt-get install -y libapache2-mod-php5 php5 php-apc php5-intl php5-xsl php5-common php5-gd php5-curl php5-dev php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-mysql php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-cli imagemagick php5-pgsql php5-xdebug

# Sendmail
apt-get install -y sendmail
# Phpmyadmin
apt-get install -y phpmyadmin
sudo ln -s /usr/share/phpmyadmin /var/www/html/

# Apache mods
a2enmod ssl
a2enmod rewrite
a2enmod suexec
a2enmod include

# Edit config files
sed -i "s@^;date.timezone =.*@date.timezone = $TIMEZONE@" /etc/php5/*/php.ini
sed -i "s@^memory_limit =.*@memory_limit = $MEMORY_LIMIT@" /etc/php5/*/php.ini
sed -i "s@^max_execution_time = .*@max_execution_time = $MAX_EXECUTION_TIME@" /etc/php5/*/php.ini
sed -i -e "$a xdebug.max_nesting_level=$XDEBUG_NESTING@" /etc/php5/*/php.ini

# Restart apache
service apache2 restart
