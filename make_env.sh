#!/bin/bash

# コマンドライン引数から OUTPUT_FILE を取得、もしなければデフォルト値を使用
OUTPUT_FILE=${1:-".env"}

# RDS_SECRET 環境変数から JSON 文字列を取得
json_data=${RDS_SECRET}

# JSON 文字列から各キーと値を抽出し、環境変数として設定
while IFS=":" read -r key value; do
    # キーの加工（ダブルクォートと余分なスペースの削除）
    clean_key=$(echo $key | sed 's/[", ]//g')

    # 値の加工（ダブルクォート、カンマ、波括弧の削除）
    clean_value=$(echo $value | sed 's/[",{}]//g')

    # 環境変数として設定
    declare "${clean_key}=${clean_value}"
done <<< "$(echo $json_data | sed 's/[:,]/\n/g')"

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
