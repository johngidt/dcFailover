#!/bin/bash

if [ $# -lt "1" ]
then
	echo "I need 1 parameter: DIR_BASE. i.e /REPOS/ITNow"
	exit 1
fi

DIR_BASE=$1

# Get the vars without the var modified
grep -v ^$(awk -F: '{print $1}' ${DIR_BASE}/tmp/key_value) ${DIR_BASE}/vars/httpd_vars.yml > ${DIR_BASE}/tmp/httpd_vars_AUX.dic 

# Append the key:value modified
cat ${DIR_BASE}/tmp/key_value >> ${DIR_BASE}/tmp/httpd_vars_AUX.dic

# Move the new file to the real var-file
rm ${DIR_BASE}/vars/httpd_vars.yml
mv ${DIR_BASE}/tmp/httpd_vars_AUX.dic ${DIR_BASE}/vars/httpd_vars.yml
