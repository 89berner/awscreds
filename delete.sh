#!/bin/bash
aws dynamodb delete-item --table-name credentials --key "{ \"name\": {\"S\": \"$1\"} }" --return-consumed-capacity TOTAL
