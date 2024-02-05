#!/bin/bash

for line in `cat ${ZBXAPIDIR}/template-id-list.txt | grep -v ^#`

do

curl -s -d '
{
    "jsonrpc": "2.0",
    "method": "configuration.export",
    "params": {
        "options": {
            "templates": [
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
