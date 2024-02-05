#!/bin/bash

buf01=`curl -s -d '
{
    "jsonrpc": "2.0",
    "method": "hostgroup.get",
    "params": {
        "output": "extend"
    },
    "auth": "'${auth}'",
    "id": 2
}
' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php`

buf02=`echo $buf01 |jq  '.result | length'
`
i=0

while [ $i -lt $buf02 ]

do

curl -s -d '
{
    "jsonrpc": "2.0",
    "method" : "hostgroup.get",
    "params": {
        "output": "extend"
    },
    "auth": "'${auth}'",
    "id": 2
}
' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq '.result['$i'].groupid' 

let i=i+1

done
