#!/bin/bash

for line in `cat ${ZBXAPIDIR}/media-id-list.txt | grep -v ^#`

do

curl -s -d '
{
    "jsonrpc": "2.0",
    "method": "configuration.export",
    "params": {
        "options": {
            "mediaTypes": [
              '${line}'
            ]
        },
        "format": "xml"
    },
    "auth": "'${auth}'",
    "id": 1
}

' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq '.result'

done
