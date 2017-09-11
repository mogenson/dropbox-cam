# dropbox-cam

Bash script to upload an image taken with the raspbery pi camera every minute.

Checks ~/.dropbox-cam-hosts for a list of hostnames (one per line). Script does
not take or upload a picture if one of the hostnames is found on the local
network.

Script uses
[dropbox_uploader.sh](https://github.com/andreafabrizi/Dropbox-Uploader) to
upload images to a dropbox folder. Dropbox_uploader.sh relies on an OAUTH token
located in ~/.dropbox_uploader

Script is run every minute by a cronjob:

```
# m h  dom mon dow   command
* * * * * /home/pi/dropbox-cam.sh
```
