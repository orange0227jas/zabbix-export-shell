#!/bin/bash

curl -s -d '
{
    "jsonrpc": "2.0",
    "method": "host.get",
    "params": {
        "output": ["host"],
        "selectGroups": "extend"
    },
    "auth": "'${auth}'",
    "id": 2
}
' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php |jq  >${ZBXAPIDIR}/hostname-json-data.txt

cat ${ZBXAPIDIR}/hostname-json-data.txt | grep -e \"host\" | sed -e 's/.*:\s//g' -e 's/\,//g' >  ${ZBXAPIDIR}/host-name-list.txt
