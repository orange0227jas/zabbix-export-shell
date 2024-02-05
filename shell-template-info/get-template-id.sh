#!/bin/bash

IFS_BACKUP=$IFS
IFS=$'\n'

for line in `cat ${ZBXAPIDIR}/template-name-list-uniq.txt | grep -v ^#`

do

curl -s -d '
{
    "jsonrpc": "2.0",
    "method": "template.get",
    "params": {
        "output": "extend",
        "filter": {
            "host": [
                "'${line}'"
           ]
         }
    },
    "auth": "'${auth}'",
    "id": 1
}
' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq  '.result[0].templateid'
done

IFS=$IFS_BACKUP
