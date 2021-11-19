#!/usr/bin/env bash

timestamp(){
    date
}

# echo "$(timestamp) Locating required resources..."
# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# cd $DIR
echo "Please Enter your Details Below ...."
read -p "Enter your name : " USER_NAME
read -s -p "Enter your password : " PASSWORD
BODY='{"ClientId": "9s990bibbsg26bepjvofubc1g","AuthParameters": {"USERNAME": "'"$USER_NAME"'","PASSWORD": "'"$PASSWORD"'"},"AuthFlow": "USER_PASSWORD_AUTH"}'
HEADER1='X-Amz-Target: AWSCognitoIdentityProviderService.InitiateAuth'
HEADER2='Content-Type: application/x-amz-json-1.1'
export IDTOKEN=`curl -s -XPOST -H "$HEADER1" -H "$HEADER2" -d "$BODY" 'https://cognito-idp.ap-south-1.amazonaws.com/' | jq -r .AuthenticationResult.IdToken`
if [ $IDTOKEN == null ]
then
    echo "Not Authenticated"
else
    echo "Authenticated user ..."
    echo "Started the downloading..."
    export URL=`curl -H "Authorization: $IDTOKEN" https://2jum04ptde.execute-api.ap-south-1.amazonaws.com/dev`
    curl -s --output myfile.sh $URL
fi
