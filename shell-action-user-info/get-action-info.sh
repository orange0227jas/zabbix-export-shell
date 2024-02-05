#!/bin/bash

curl -s -d '
{
    "jsonrpc": "2.0",
    "method": "action.get",
    "params": {
        "output": "extend",
        "selectOperations": "extend",
        "selectRecoveryOperations": "extend",
        "selectUpdateOperations": "extend",
        "selectFilter": "extend"
    },
    "auth": "'${auth}'",
    "id": 2
}
' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq
