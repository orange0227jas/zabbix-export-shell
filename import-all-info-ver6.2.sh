#!/bin/bash

ZBXAPIDIR=`pwd`
export ZBXAPIDIR
echo -n "INPU_Zabbix-host-IPaddress:"
read zabbixIPaddress
echo -n "INPU_Zabbix-login-user:"
read zabbixUserName
echo -n "INPU_Zabbix-login-password:"
read zabbixPassword

export zabbixIPaddress
export zabbixUserName
export zabbixPassword

ZabbixWeb=http://${zabbixIPaddress}/zabbix/
export ZabbixWeb
auth=`bash ${ZBXAPIDIR}/shell-api-auth/zabbix-auth.sh`
export auth

IFS_BACKUP=$IFS
IFS=$'\n'


for line in `cat "$1" | grep -v ^# | sed -e 's/^"//' |sed -e 's/"$//'`

do

curl -s -d '
{
    "jsonrpc": "2.0",
    "method": "configuration.import",
    "params": {
        "format": "xml",
        "rules": {
            "discoveryRules": {
                "createMissing": true,
                "updateExisting": true,
                "deleteMissing": true
            },
            "graphs": {
                "createMissing": true,
                "updateExisting": true,
                "deleteMissing": true
            },
            "host_groups": {
                "createMissing": true,
                "updateExisting": true
            },
            "template_groups": {
                "createMissing": true,
                "updateExisting": true
            },
            "hosts": {
                "createMissing": true,
                "updateExisting": true
            },
            "httptests": {
                "createMissing": true,
                "updateExisting": true,
                "deleteMissing": true
            },
            "images": {
                "createMissing": true,
                "updateExisting": true
            },
            "items": {
                "createMissing": true,
                "updateExisting": true,
                "deleteMissing": true
            },
            "maps": {
                "createMissing": true,
                "updateExisting": true
            },
            "mediaTypes": {
                "createMissing": true,
                "updateExisting": true
            },
            "templateLinkage": {
                "createMissing": true,
                "deleteMissing": true
            },
            "templates": {
                "createMissing": true,
                "updateExisting": true
            },
            "templateDashboards": {
                "createMissing": true,
                "updateExisting": true,
                "deleteMissing": true
            },
            "triggers": {
                "createMissing": true,
                "updateExisting": true,
                "deleteMissing": true
            },
            "valueMaps": {
                "createMissing": true,
                "updateExisting": true,
                "deleteMissing": true
            }
        },
        "source": "'${line}'"
    },
    "auth": "'${auth}'",
    "id": 1
}

' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php

done

IFS=$IFS_BACKUP
