#!/bin/bash

user=$(echo $1 | tr -dc '[:alnum:]_\n\r' | tr '[:upper:]' '[:lower:]')
RESPONSE=$(aws dynamodb get-item --table-name secrets --key "{\"name\":{\"S\":\"$user\"}}" --region us-west-2 --attributes-to-get value 2>/dev/null|grep "S"|cut -d ":" -f 2|cut -d '"' -f 2)

if [ -z "$RESPONSE" ]; then
	echo -n "Error"
else
	echo -n $RESPONSE
fi
