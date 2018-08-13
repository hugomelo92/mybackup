#!/bin/bash

BKP_PATH=/var/www/mybackup
MYSQLDUMP_CMD="mysqldump -uuser -ppass --opt --routines -E --triggers "
NOW=$(date +'%Y-%m-%dT%T' | sed 's/:/-/g')
TARFILE=backup-$NOW.tar.gz.enc
PUBLIC_DIR=/var/www/project/public_html

rm -rfv $BKP_PATH/*.dump

echo "backup"
$MYSQLDUMP_CMD database_name > $BKP_PATH/database_name-$NOW.dump

sed -i "s/DEFINER=\`.*\`@\`%\`//g" $BKP_PATH/*.dump

cd $BKP_PATH
tar czv *.dump | openssl enc -aes-256-cbc -pass pass:'encryption_key' -e > $BKP_PATH/$TARFILE
ln -sf $BKP_PATH/$TARFILE $PUBLIC_DIR/backup-latest.tar.gz.enc
