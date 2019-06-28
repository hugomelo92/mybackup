#!/usr/bin/env bash

curl -L -O http://url/backup-latest.tar.gz.enc
openssl aes-256-cbc -pass pass:"encryption_key" -d -in backup-latest.tar.gz.enc | tar xz
