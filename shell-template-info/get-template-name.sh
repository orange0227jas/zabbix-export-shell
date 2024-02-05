#!/bin/bash

cat  ${ZBXAPIDIR}/xmldata-host.txt|sed -e 's/<template><name>/\n/g' -e 's/<\/name><\/template>/\n/g' |sed -e  's/^\".*//g' |sed -e 's/^<.*//g' |sed '/^$/d'
