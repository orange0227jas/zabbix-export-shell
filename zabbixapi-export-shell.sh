#!/bin/bash
##################################################
#                                                #
#param setting                                   # 
#                                                #
##################################################
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

ZBXAPIDIR=`pwd`
export ZBXAPIDIR

ZabbixWeb=http://${zabbixIPaddress}/zabbix/
export ZabbixWeb
#get zabbix auth
auth=`bash ${ZBXAPIDIR}/shell-api-auth/zabbix-auth.sh`
export auth

##################################################
#
#txt file delete
#
#################################################

rm -f ${ZBXAPIDIR}/host-name-list.txt
rm -f ${ZBXAPIDIR}/host-id-list.txt
rm -f ${ZBXAPIDIR}/template-id-list.txt
rm -f ${ZBXAPIDIR}/template-name-list.txt
rm -f ${ZBXAPIDIR}/template-name-list-uniq.txt
rm -f ${ZBXAPIDIR}/hostgroup-id-list.txt
rm -f ${ZBXAPIDIR}/hostgroup-name-list.txt
rm -f ${ZBXAPIDIR}/xmldata-hostgroup.txt
rm -f ${ZBXAPIDIR}/xmldata-host.txt
rm -f ${ZBXAPIDIR}/xmldata-template.txt
rm -f ${ZBXAPIDIR}/action-json-data.txt
rm -f ${ZBXAPIDIR}/user-json-data.txt
rm -f ${ZBXAPIDIR}/usergroup-json-data.txt
rm -f ${ZBXAPIDIR}/media-id-list.txt
rm -f ${ZBXAPIDIR}/media-name-list.txt
rm -f ${ZBXAPIDIR}/xmldata-media.txt
rm -f ${ZBXAPIDIR}/hostid-json-data.txt
rm -f ${ZBXAPIDIR}/hostname-json-data.txt

##################################################
#
# get action,user and usergroup data
#
##################################################
echo "Getting action and user data..."
#create action-json-data.txt
bash ${ZBXAPIDIR}/shell-action-user-info/get-action-info.sh > ${ZBXAPIDIR}/action-json-data.txt

#create user-json-data.txt
bash ${ZBXAPIDIR}/shell-action-user-info/get-user-info.sh > ${ZBXAPIDIR}/user-json-data.txt

#create usergroup-json-data.txt
bash ${ZBXAPIDIR}/shell-action-user-info/get-usergroup-info.sh > ${ZBXAPIDIR}/usergroup-json-data.txt

#create role-json-data.txt
bash ${ZBXAPIDIR}/shell-action-user-info/get-role-info.sh > ${ZBXAPIDIR}/role-json-data.txt
echo "action and user data  has been created"

##################################################
#
# Create zabbix-host XML data 
#
##################################################
#create host-id-list.txt
echo "Creating host-id-list.txt..."
bash ${ZBXAPIDIR}/shell-host-info/get-host-id.sh > ${ZBXAPIDIR}/host-id-list.txt
echo "OK. Total: `cat ${ZBXAPIDIR}/host-id-list.txt| wc -l` hosts"

#create host-name-list.txt
echo "Creating host-name-list.txt..."
bash ${ZBXAPIDIR}/shell-host-info/get-host-name.sh > ${ZBXAPIDIR}/host-name-list.txt
echo "OK"

#create XML export data (host)
echo "Creating xmldata-host.txt..."
bash ${ZBXAPIDIR}/shell-host-info/export-host-info.sh 
echo "OK"
echo "Host data has been created"

##################################################
#
# Create zabbix-hostgroup XML data
#
##################################################
#create hostgroup-id-list.txt
echo "Creating hostgroup-id-list.txt..."
bash ${ZBXAPIDIR}/shell-hostgroup-info/get-hostgroup-id.sh > ${ZBXAPIDIR}/hostgroup-id-list.txt
echo "OK"

#create hostgroup-name-list.txt
echo "Creating hostgroup-name-list.txt..."
bash ${ZBXAPIDIR}/shell-hostgroup-info/get-hostgroup-name.sh > ${ZBXAPIDIR}/hostgroup-name-list.txt
echo "OK"

#create XML export data (hostgroup)
echo "Creating xmldata-hostgroup.txt..."
bash ${ZBXAPIDIR}/shell-hostgroup-info/export-hostgroup-info.sh > ${ZBXAPIDIR}/xmldata-hostgroup.txt
echo "OK"
echo "Hostgroup data has been created"

##################################################
#
# Create zabbix-template XML data
#
##################################################
#create template-name-list.txt
echo "Creating template-name-list-uniq.txt..."
bash ${ZBXAPIDIR}/shell-template-info/get-template-name.sh > ${ZBXAPIDIR}/template-name-list.txt
sort ${ZBXAPIDIR}/template-name-list.txt | uniq > ${ZBXAPIDIR}/template-name-list-uniq.txt
echo "OK Total:`cat ${ZBXAPIDIR}/template-name-list-uniq.txt | wc -l` templates"

#create template-id-list.txt
echo "Creating template-id-list.txt..."
bash ${ZBXAPIDIR}/shell-template-info/get-template-id.sh > ${ZBXAPIDIR}/template-id-list.txt
echo "OK"

#create XML export data (template)
echo "Creating xmldata-template.txt..."
bash ${ZBXAPIDIR}/shell-template-info/export-template-info.sh > ${ZBXAPIDIR}/xmldata-template.txt
echo "OK"
echo "Template data has been created"

##################################################
#
# Create zabbix-mediaType XML data
#
##################################################
#create media-id-list.tx
echo "Creating media-id-list.txt..."
bash ${ZBXAPIDIR}/shell-media-info/get-media-id.sh > ${ZBXAPIDIR}/media-id-list.txt
echo "OK"

#create media-name-list.txt
echo "Creating media-name-list.txt..."
bash ${ZBXAPIDIR}/shell-media-info/get-media-name.sh > ${ZBXAPIDIR}/media-name-list.txt
echo "OK"

#create XML export data (host)
echo "Creating xmldata-media.txt..."
bash ${ZBXAPIDIR}/shell-media-info/export-media-info.sh > ${ZBXAPIDIR}/xmldata-media.txt
echo "OK"
echo "MediaTypes data has been created"
echo "Finish."
