#!/bin/bash
#
# Event handler script for restarting the web server on the local machine
#
# Note: This script will only restart the web server if the service is
#       retried 3 times (in a "soft" state) or if the web service somehow
#       manages to fall into a "hard" error state.
#

TIMESTAMP=`date +"%s"`
R=$RANDOM
AUXFILE="file_${TIMESTAMP}${R}.json"
DEBUGFILE="debug_${TIMESTAMP}${R}.txt"

echo "{"		                   >> ${AUXFILE}
echo "     \"extra_vars\": {"              >> ${AUXFILE}
echo "        \"host_or_group\": \"${4}\"" >> ${AUXFILE}
echo "      }"                             >> ${AUXFILE}
echo "}"                                   >> ${AUXFILE}

#> ${DEBUGFILE}
#echo "PARAM 1 = ${1}" >> ${DEBUGFILE}
#echo "PARAM 2 = ${2}" >> ${DEBUGFILE}
#echo "PARAM 3 = ${3}" >> ${DEBUGFILE}
#echo "PARAM 4 = ${4}" >> ${DEBUGFILE}

#rm ${DEBUGFILE}

case "$1" in
OK)
	;;
WARNING)
	;;
UNKNOWN)
	;;
CRITICAL)
	case "$2" in
	SOFT|HARD)
		case "$3" in
		2)
		logger "ooOoo--- RUNNING ANSIBLE PLAYBOOK ---ooOoo"
		/usr/bin/curl -X POST --user itoperator:redhat123. --data @${AUXFILE} https://tower/api/v1/job_templates/24/launch/ -k -H "Content-Type: application/json"
			;;
		esac

	esac
	;;
esac
exit 0
