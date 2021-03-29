#!/bin/bash
FLOW="$1"
ENVIRONMENT="$2"

case $# in
  2)
    ENVIRONMENT="$2"
    ;;
  1)
    ENVIRONMENT="local"
    ;;
  *)
    echo "not enough arguments supplied.  You must supply the flowName to this command, and have a creds/${ENVIRONMENT}.username and creds/${ENVIRONMENT}.password file populated."
    return 1
    ;;
esac    

source setEnvForUpload.sh $ENVIRONMENT

if [ -z $FLOW_TOKEN ] ;
then
	if [ -z $COOKIE ]
	then
		echo "no valid cookie"
		return 1
	fi
	curl $CURL_ARGS -X GET -H "Cookie: JSESSIONID=$COOKIE" "$HOST/flows/$FLOW"
else
	curl $CURL_ARGS -X GET -H "flow-token: $FLOW_TOKEN" "$HOST/flows/$FLOW"
fi
