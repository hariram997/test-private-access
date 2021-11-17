#!/usr/bin/env bash

timestamp(){
    date
}

echo "$(timestamp) Locating required resources..."
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR
export URL=`curl https://2jum04ptde.execute-api.ap-south-1.amazonaws.com/dev`
curl -s --output myfile.sh $URL
