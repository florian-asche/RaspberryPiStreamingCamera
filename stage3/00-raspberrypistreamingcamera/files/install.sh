#!/bin/bash

# Preparing Raspbian - Enable ssh
touch /boot/ssh

# Update System and install nessesary and usefull packages
apt-get update -y && apt-get -y dist-upgrade
apt-get install -y vim bash bash-completion zsh grml-zsh-config avahi nss-mdns wpa_supplicant termite-terminfo console-common less 

# install interfaces file
cp interfaces /etc/network/

# Install zero-conf to make the pi easier to find on the network
#sed -i '/^hosts: /s/files dns/files mdns dns/' /etc/nsswitch.conf
#ln -sf /usr/lib/systemd/system/avahi-daemon.service /etc/systemd/system/multi-user.target.wants/avahi-daemon.service

# Install UV4L components - Add the supplier's repository key to our key database
curl http://www.linux-projects.org/listing/uv4l_repo/lrkey.asc | apt-key add -
echo "deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/ jessie main" > /etc/apt/sources.list.d/uv4l.list
apt-get update

# Install UV4L components - Now fetch and install the required modules.
apt-get -y install uv4l uv4l-raspicam
apt-get -y install uv4l-raspicam-extras
apt-get -y install uv4l-server

# Install UV4L components - Let's copy our own config files in place.
cp uv4l-raspicam.conf /etc/uv4l/uv4l-raspicam.conf
cp uv4l-server.conf /etc/uv4l/uv4l-server.conf
sed -i "s/--editable-config-file=\$CONFIGFILE/--server-config-file=\/etc\/uv4l\/uv4l-server.conf/g" /etc/init.d/uv4l_raspicam

# Install UV4L components - Notify systemd of service changes.
systemctl daemon-reload

# Install the RTSP server - we will be compiling software, so install some prerequisite
apt-get -y install cmake make automake

# Install the RTSP server - first compile the live555 library as a prerequisite
wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz -O - | tar xvzf -
cd live
./genMakefiles linux
make CPPFLAGS=-DALLOW_RTSP_SERVER_PORT_REUSE=1 install
cd ..

# Install the RTSP server - clone the rtsp server's git repository, compile and install
apt-get -y install git 
git clone https://github.com/mpromonet/v4l2rtspserver.git
apt-get install -y libasound2-dev liblog4cpp5-dev
cd v4l2rtspserver
cmake . && make
make install
cd ..

# Install the RTSP server - Put system service file for RTSP server into place
cp RTSP-Server.service /etc/systemd/system/RTSP-Server.service

# Install the RTSP server - Notify systemd of a service installation.
systemctl daemon-reload

# Install the RTSP server - Set the startup for the service to disabled for our default config.
systemctl enable RTSP-Server.service
