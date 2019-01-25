# RaspberryPiStreamingCamera
This project uses the Raspberry Pi Camera. The image will be streamed in H.264 over the integrated RTSP Server.
This project is meant to be very secure, therefore we renounce e.g. on a web interface, which whould provides an attack area.

## Build:
The Build on Travis-CI failed due to missing binfmt-support. I am now using my own Build System.

## Used Software by this project:
* Raspbian Jessie (minmal) image.
* The UV4L software from http://www.linux-projects.org
* The RTSP server from https://github.com/mpromonet/h264_v4l2_rtspserver

## Hardware Tips:
* You can buy a Raspberry Pi Zero W (very small) with Wirless Onboard and a Housing here: https://buyzero.de/collections/boards-kits/products/copy-of-raspberry-pi-zero-w?variant=31485043090
* All other nesessary things you can also get there. 
* With that hardware setup you get 25FPS in 720p H264 over RTSP.

## Howto:
* Unzip your downloaded image, and write it to SD card with win32 disk imager.
* Place a ```wpa_supplicant.conf``` file on the boot partition to connect the camera with you WIFI. Consider multiple AP for am more stable communication in case an AP goes down.
* The Raspberry Pi is configured for DHCP and will therefore retrieve an IP address, that will displayed on boot, in case you cant find it in your router/DHCP Server.
* SSH is enabled by default. The default login is: username ```'pi'``` and password ```'raspberry'```. ***!!! You need to change that. !!!***
* If you can access the PI with ssh you should be able to connect the RTSP Server (for example with vlc) with URL ```rtsp://<PI-IP-ADDRESS>:8554```

## What is handled by the installation files or image?
* Enable camera (Image only)
* Preparing Raspbian - Regenerate security keys (best practice) (Image only)
* Preparing Raspbian - Enable ssh
* Update System
* Install UV4L components
* Install the RTSP server
* Best practise configuration (all working from start)

Optional:
* Readonly - Remove rsyslog and install a memory resident variant
* Readonly - configure the boot options to be read-only on next boot

## Build your own image:
* checkout this repository
* install docker (see https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)
* (sudo) ./build-docker.sh
* Image zip file you can find in deploy directory
* docker rm pigen_work

## Install with script, manually on existing device:
* checkout this repository
```shell
git clone git@github.com:florian-asche/RaspberryPiStreamingCamera.git
cd RaspberryPiStreamingCamera
```
* goto stage3/files directory
```shell
cd stage3
cd files
```
* Enable camera
```shell
raspi-config
[...]
```
* Install Software and configure them
```shell
./install.sh
```

## Optional: Make device readonly:
```shell
cd /installfiles/
./make_me_readonly.sh
```

## Configuration:
The configuration is made the best way i could find. It should be perfect. If you still want to change that, you can to so here:
```shell
sudo su
cd /etc/uv4l/
```

## Thanks:
* Thanks to https://github.com/RPi-Distro/pi-gen for the Image Buildprocess.
* Thanks to https://github.com/ronnyvdbr/RaspberryIPCamera, my project was based on his work.
