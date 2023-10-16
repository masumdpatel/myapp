#!/bin/bash

#ssh as root user

#Change directory to /tmp
cd /tmp

#Download the kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-8.10.3-x86_64.rpm

# #Expand the tarball
# tar -xzf /tmp/SP_CLIENT_8.1.17_LIN86_ML.tar.gz

# #Change directory to /tmp/TSMCLI_LNX/tsmcli/linux86
# cd TSMCLI_LNX/tsmcli/linux86

# Install the 64-bit rom package
sudo rpm --install kibana-8.10.3-x86_64.rpm

# # Install the TSM 64-bit API packages
# rpm -i TIVsm-API64.x86_64.rpm TIVsm-APIcit.x86_64.rpm

# # Install the TSM backup-archive (B/A) client packages
# rpm -i TIVsm-BA.x86_64.rpm TIVsm-BAcit.x86_64.rpm
