#!/bin/bash

curl -s -d '{
    "jsonrpc": "2.0",
    "method": "user.login",
    "params": {
        "user": "'${zabbixUserName}'",
        "password": "'${zabbixPassword}'" 
    },
    "id": 1,
    "auth": null
}' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | gawk -F'"' '{print $8}'
