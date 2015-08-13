#!/bin/bash

KEYID=$3

VALUE=$(aws kms encrypt --key-id $KEYID --plaintext "$2" --query CiphertextBlob --output text)

/usr/bin/aws dynamodb put-item --table-name credentials --item "{ \"name\": {\"S\": \"$1\"}, \"value\": {\"S\": \"$VALUE\"}  }"  --return-consumed-capacity TOTAL
