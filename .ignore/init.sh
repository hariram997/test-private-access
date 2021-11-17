#!/usr/bin/env bash

timestamp(){
    date
}

echo "$(timestamp) Locating required resources..."
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR
USER_NAME=ashwathi
PASSWORD=Sweety@1
BODY='{"ClientId": "9s990bibbsg26bepjvofubc1g","AuthParameters": {"USERNAME": "'"$USER_NAME"'","PASSWORD": "'"$PASSWORD"'"},"AuthFlow": "USER_PASSWORD_AUTH"}'
HEADER1='X-Amz-Target: AWSCognitoIdentityProviderService.InitiateAuth'
HEADER2='Content-Type: application/x-amz-json-1.1'
export STATUS_CODE=`curl -s  -o /dev/null -w "%{http_code}" -XPOST -H "$HEADER1" -H "$HEADER2" -d "$BODY" 'https://cognito-idp.ap-south-1.amazonaws.com/'`
if [ $STATUS_CODE == 200 ]
then
    echo "Authenticated user ..."
    echo "Started the downloading..."
    export URL=`curl https://2jum04ptde.execute-api.ap-south-1.amazonaws.com/dev`
    curl -s --output myfile.sh $URL
else
    echo "Not Authenticated"
fi