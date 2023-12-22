#!/bin/bash

# コマンドライン引数から OUTPUT_FILE を取得、もしなければデフォルト値を使用
OUTPUT_FILE=${1:-".env"}

# RDS_SECRET 環境変数から JSON 文字列を取得
json_data=${RDS_SECRET}

# 波括弧を削除
json_data=$(echo $json_data | sed 's/[{}]//g')

# カンマとコロンで区切られた各ペアを処理
IFS=',' read -ra PAIRS <<< "$json_data"
for pair in "${PAIRS[@]}"; do
    # キーと値を分割
    IFS=':' read -r key value <<< "$pair"

    # 環境変数として設定
    declare "$key=$value"
done

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
