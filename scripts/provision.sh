#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Set My Timezone

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Force Locale.

echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
locale-gen en_US.UTF-8

# Configure MySQL remote access.

mysql --user="root" --password="secret" -e "CREATE USER 'lumber'@'0.0.0.0' IDENTIFIED BY 'secret';"
mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO 'lumber'@'0.0.0.0' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO 'lumber'@'%' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
mysql --user="root" --password="secret" -e "FLUSH PRIVILEGES;"
mysql --user="root" --password="secret" -e "CREATE DATABASE lumber;"
service mysql restart

# Install Postgres

apt-get install -y postgresql-9.5 postgresql-contrib-9.5

# Configure Postgres Remote Access

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.5/main/postgresql.conf
echo "host    all             all             10.0.2.2/32               md5" | tee -a /etc/postgresql/9.5/main/pg_hba.conf
sudo -u postgres psql -c "CREATE ROLE lumber LOGIN UNENCRYPTED PASSWORD 'secret' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo -u postgres /usr/bin/createdb --echo --owner=lumber lumber
service postgresql restart

# Install Gulp CLI.

/usr/bin/npm install -g gulp-cli

# Install Japanese Font.

wget -O ./NotoSansJapanese.zip https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip
unzip -d ./NotoSansJapanese NotoSansJapanese.zip
mkdir -p /usr/share/fonts/opentype
mv -fv ./NotoSansJapanese /usr/share/fonts/opentype/NotoSansJapanese
rm -rf ./NotoSansJapanese.zip
fc-cache -fv

# Enable swap memory.

/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1

# Minimize the disk image.

echo "Minimizing disk image..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
