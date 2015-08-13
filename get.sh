#!/bin/bash

user=$(echo $1 | tr -dc '[:alnum:]_\n\r' | tr '[:upper:]' '[:lower:]')

RESPONSE=$(aws dynamodb get-item --table-name credentials --key "{\"name\":{\"S\":\"$user\"}}" --region us-east-1 --attributes-to-get value 2>/dev/null|grep "S"|cut -d ":" -f 2|cut -d '"' -f 2)

echo "$RESPONSE" | base64 --decode > /tmp/encrypted

DRESPONSE=$(aws kms decrypt --ciphertext-blob fileb:///tmp/encrypted  --output text --query Plaintext | base64 --decode)

if [ -z "$RESPONSE" ]; then
	echo -n "Error"
else
	echo -n $DRESPONSE
fi
