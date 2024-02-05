#!/bin/bash
##################################################
#
#param setting
#
#################################################
ZBXAPIDIR=`pwd`
echo -n "INPU_Zabbix-host-IPaddress:"
read zabbixIPaddress
echo -n "INPU_Zabbix-login-user:"
read zabbixUserName
stty -echo
echo -n "INPU_Zabbix-login-password:"
read zabbixPassword
stty echo

export zabbixIPaddress
export zabbixUserName
export zabbixPassword

ZabbixWeb=http://${zabbixIPaddress}/zabbix/
export ZabbixWeb
#get zabbix auth
auth=`bash ${ZBXAPIDIR}/shell-api-auth/zabbix-auth.sh`
export auth
echo ""
echo $auth
