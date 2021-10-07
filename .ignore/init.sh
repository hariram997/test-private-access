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
elif [ $STAGE == "test" ]
then
    echo "$(timestamp) Using Test Artifact..."
    ARTIFACT_URL="https://guru-shifu-artifacts.s3.ap-south-1.amazonaws.com/Guru-Shifu-Trainee-Output/outputProd/guru-shifu-twi-prod-gitpod.tar.gz"
else
    echo "$(timestamp) Using Dev Artifact..."
    ARTIFACT_URL="https://guru-shifu-artifacts.s3.ap-south-1.amazonaws.com/Guru-Shifu-Trainee-Output/outputTest/guru-shifu-twi-test-gitpod.tar.gz"
fi
echo "$(timestamp) Starting download of artifact ..."
curl -s --output guru-shifu.tar.gz "$ARTIFACT_URL"
echo "$(timestamp) Artifact download complete."
echo "$(timestamp) Unzipping guru-shifu tarball.."
tar -xf guru-shifu.tar.gz
echo "$(timestamp) Unzip complete"
mkdir /workspace/gitpod/m2-repository
printf '<settings>\n  <localRepository>/workspace/gitpod/m2-repository/</localRepository>\n</settings>\n' > /home/gitpod/.m2/settings.xml
echo "$(timestamp) Loading guru-shifu images..."
docker load -i guru-shifu-images.tar.gz
echo "$(timestamp) Guru-shifu images loaded successfully"
