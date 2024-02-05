#!/bin/bash

curl -s -d '
{
    "jsonrpc": "2.0",
    "method": "host.get",
    "params": {
        "output": ["hostid"],
        "selectGroups": "extend"
    },
    "auth": "'${auth}'",
    "id": 2
}
' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php |jq  > ${ZBXAPIDIR}/hostid-json-data.txt

cat ${ZBXAPIDIR}/hostid-json-data.txt |grep hostid |sed -e 's/.*:\s//g' -e 's/\,//g'
