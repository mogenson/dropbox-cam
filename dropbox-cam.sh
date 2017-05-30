#!/bin/bash

HOSTS_FILE="$HOME/.dropbox-cam-hosts"
IMAGE_DIR="$HOME/images/"
IMAGE_NAME="image-$(date +%Y-%m-%d-%R).jpg"

while read hostname
do
    # if ping is successful exit script
    ping -q -c1 $hostname && exit
done < $HOSTS_FILE

raspistill -n -rot 90 -o $IMAGE_DIR$IMAGE_NAME

dropbox_uploader.sh upload $IMAGE_DIR$IMAGE_NAME "/image.jpg"

# 8000 images is about 24 GB
if [[ $(ls $IMAGE_DIR | wc -l) -gt 8000 ]]
then
    rm -v $IMAGE_DIR$(ls $IMAGE_DIR -t | tail -1)
fi
