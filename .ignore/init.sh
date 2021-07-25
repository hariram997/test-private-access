#!/usr/bin/env bash

timestamp(){
    date
}

echo "$(timestamp) Locating required resources..."
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR
if [ $STAGE == "prod" ]
then
    echo "$(timestamp) Using Prod Artifact..."
    ARTIFACT_URL="https://guru-shifu-artifacts.s3.ap-south-1.amazonaws.com/Guru-Shifu-Trainee-Output/outputProd/guru-shifu-twi-prod-gitpod.tar.gz"
else
    echo "$(timestamp) Using Dev Artifact..."
    ARTIFACT_URL="https://guru-shifu-artifacts.s3.ap-south-1.amazonaws.com/Guru-Shifu-Trainee-Output/outputDev/guru-shifu-twi-dev-gitpod.tar.gz"
fi
curl -s --output guru-shifu.tar.gz "$ARTIFACT_URL"
tar -xf guru-shifu.tar.gz
mkdir /workspace/gitpod/m2-repository
printf '<settings>\n  <localRepository>/workspace/gitpod/m2-repository/</localRepository>\n</settings>\n' > /home/gitpod/.m2/settings.xml
echo "$(timestamp) Loading guru-shifu images..."
docker load -i guru-shifu-images.tar.gz
