#!/bin/bash

# jqがインストールされているかチェックし、なければインストール
if ! command -v jq &> /dev/null; then
    echo "jqがインストールされていません。インストールします。"
    sudo apt-get update && sudo apt-get install -y jq
fi

# RDS_SECRETからnameとpasswordを抽出し、.envに書き出す
if [ -z "${RDS_SECRET}" ]; then
    echo "環境変数RDS_SECRETが設定されていません。"
    # exit 1
fi

# JSONからnameとpasswordを抽出
name=$(echo "${RDS_SECRET}" | jq -r '.name')
password=$(echo "${RDS_SECRET}" | jq -r '.password')

# .envファイルに書き出す
echo "NAME=$name" > .env
echo "PASSWORD=$password" >> .env

echo ".envファイルに書き出しました。"

cat .env

go run main.go
