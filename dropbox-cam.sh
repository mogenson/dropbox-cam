#!/bin/bash

IMAGE_DIR="/home/pi/images/"
IMAGE_NAME="image-$(date +%Y-%m-%d-%R).jpg"

# test for Amy's phone
ping -c2 SAMSUNG-SM-G930A.lan
[ $? -eq 0 ] && exit

# test for Mike's phone
ping -c2 android-68b316b31938f1ad.lan
[ $? -eq 0 ] && exit

# test for Amy's computer
ping -c2 Amys-MBP-2.lan
[ $? -eq 0 ] && exit

# test for Mike's computer
ping -c2 compooper.lan
[ $? -eq 0 ] && exit

raspistill -n -rot 90 -o $IMAGE_DIR$IMAGE_NAME

dropbox_uploader.sh upload $IMAGE_DIR$IMAGE_NAME "/image.jpg"

# 8000 images is about 24 GB
if [[ $(ls $IMAGE_DIR | wc -l) -gt 8000 ]]
then
    rm -v $IMAGE_DIR$(ls $IMAGE_DIR -t | tail -1)
fi
