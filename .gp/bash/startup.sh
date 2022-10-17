#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2022 Modamod
#
# startup.sh
# Description:
# Initializes the database and starts the snipeit app.
#
# Notes:
# Rerunning this script will update the db password for snipeit user with random passowrd each time.
#


mysqluserpw="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16; echo)"
mysql -u root -e "CREATE USER IF NOT EXISTS 'snipeit'@'localhost';"
mysql -u root -e "ALTER USER 'snipeit'@'localhost' IDENTIFIED BY '${mysqluserpw}';"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS snipeit;GRANT ALL PRIVILEGES ON snipeit.* TO 'snipeit'@'localhost'; FLUSH PRIVILEGES;"
cp -f .env.gitpod.example .env
sed -i "s|^\\(DB_PASSWORD=\\).*|\\1'${mysqluserpw}'|" .env
sed -i "s|APP_URL=|APP_URL=${GITPOD_WORKSPACE_URL}|g" .env
sed -i "s|APP_URL=https://|APP_URL=https://8000-|g" .env
composer install
php artisan migrate --force
php artisan key:generate
php -S 0.0.0.0:8000 -t public
