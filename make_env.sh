#!/bin/bash

# コマンドライン引数から OUTPUT_FILE を取得、もしなければデフォルト値を使用
OUTPUT_FILE=${1:-".env"}

# RDS_SECRET 環境変数から JSON 文字列を取得
json_data=${RDS_SECRET}

# JSON 文字列を解析して各キーの値を取得
password=$(echo $json_data | grep -o '"password":"[^"]*' | grep -o '[^"]*$')
dbname=$(echo $json_data | grep -o '"dbname":"[^"]*' | grep -o '[^"]*$')
engine=$(echo $json_data | grep -o '"engine":"[^"]*' | grep -o '[^"]*$')
port=$(echo $json_data | grep -o '"port":[^,]*' | grep -o '[0-9]*')
dbInstanceIdentifier=$(echo $json_data | grep -o '"dbInstanceIdentifier":"[^"]*' | grep -o '[^"]*$')
host=$(echo $json_data | grep -o '"host":"[^"]*' | grep -o '[^"]*$')
username=$(echo $json_data | grep -o '"username":"[^"]*' | grep -o '[^"]*$')

# .env ファイルに書き出す
echo "password=${password}" > ${OUTPUT_FILE}
echo "dbname=${dbname}" >> ${OUTPUT_FILE}
echo "engine=${engine}" >> ${OUTPUT_FILE}
echo "port=${port}" >> ${OUTPUT_FILE}
echo "dbInstanceIdentifier=${dbInstanceIdentifier}" >> ${OUTPUT_FILE}
echo "host=${host}" >> ${OUTPUT_FILE}
echo "username=${username}" >> ${OUTPUT_FILE}
echo "DATABASE_URL=mysql://${username}:${password}@${host}:${port}/${dbname}" >> ${OUTPUT_FILE}

# その他の環境変数を .env ファイルに書き出す
echo "PRODUCT=${PRODUCT}" >> ${OUTPUT_FILE}
echo "STAGE=${STAGE}" >> ${OUTPUT_FILE}
echo "IS_DDB_LOCAL=${IS_DDB_LOCAL}" >> ${OUTPUT_FILE}
echo "AWS_REGION=${AWS_REGION}" >> ${OUTPUT_FILE}
echo "MYKINSO_API_URL=${MYKINSO_API_URL}" >> ${OUTPUT_FILE}

# 確認のために設定した環境変数を表示
cat ${OUTPUT_FILE}
