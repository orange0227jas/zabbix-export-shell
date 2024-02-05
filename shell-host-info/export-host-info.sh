#!/bin/bash

i=0

for line in `cat ${ZBXAPIDIR}/host-id-list.txt | grep -v ^#`

do

curl -s -d '
{
    "jsonrpc": "2.0",
    "method": "configuration.export",
    "params": {
        "options": {
            "hosts": [
              '${line}'
            ]
        },
        "format": "xml"
    },
    "auth": "'${auth}'",
    "id": 1
}

' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq '.result' >> ${ZBXAPIDIR}/xmldata-host.txt

let i=i+1

if [ $(($i % 25)) -eq 0 ]; then
  echo "$i host data created"
fi

done
