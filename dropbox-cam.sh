#!/bin/bash

HOSTS_FILE="/home/pi/.dropbox-cam-hosts"
IMAGE_DIR="/home/pi/images/"
IMAGE_NAME="image-$(date +%Y-%m-%d-%R).jpg"
IMAGE_DIR_SIZE=$(echo 24G | numfmt --from=iec)

while read hostname
do
    # if ping is successful exit script
    ping -q -c1 $hostname && exit
done < $HOSTS_FILE

# take a picture and save it to the IMAGE_DIR
raspistill -n -rot 90 -o $IMAGE_DIR$IMAGE_NAME

# upload that image to dropbox
dropbox_uploader.sh upload $IMAGE_DIR$IMAGE_NAME "/image.jpg"

# delete the oldest file in IMAGE_DIR until the directory size is
# less than or equal to IMAGE_DIR_SIZE
# directory size is measured in bytes, IMAGE_DIR_SIZE is converted to bytes
while [[ $(du -B 1 $IMAGE_DIR | cut -f 1) -gt $IMAGE_DIR_SIZE ]]
do
    rm $IMAGE_DIR$(ls $IMAGE_DIR -t | tail -1)
done
