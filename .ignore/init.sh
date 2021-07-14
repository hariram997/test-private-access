#!/usr/bin/env bash
echo "Locating required resources..."
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR
curl -s --output guru-shifu.tar.gz "https://guru-shifu-artifacts.s3.ap-south-1.amazonaws.com/Guru-Shifu-Trainee-Output/outputDev/guru-shifu-twi-dev-gitpod.tar.gz" 
tar -xf guru-shifu.tar.gz
mkdir /workspace/gitpod/m2-repository
printf '<settings>\n  <localRepository>/workspace/gitpod/m2-repository/</localRepository>\n</settings>\n' > /home/gitpod/.m2/settings.xml
echo "Loading guru-shifu images..."
docker load -i guru-shifu-images.tar.gz
