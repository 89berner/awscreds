#!/bin/bash

/usr/bin/aws dynamodb put-item --table-name credentials --item "{ \"name\": {\"S\": \"$1\"}, \"value\": {\"S\": \"$2\"}  }"  --return-consumed-capacity TOTAL
