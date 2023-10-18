#!/bin/bash

set -ex
LOG_FILES_LOCATION="/opt/deploy_logs"
DATE=$(date +"%Y-%m-%d-%H-%M")

#function for proccess kill
kill_process() {
        CHECK_PROCESS=$(ps -ef | grep $1 | wc -l)

        if [[ $CHECK_PROCESS -gt 1 ]]; then
		echo "$1 proccess is running" >> $LOG_FILES_LOCATION/unistallation-logs-$DATE.txt
		echo "killing proccess for $1" >> $LOG_FILES_LOCATION/unistallation-logs-$DATE.txt
		systemctl stop kibana
        else
        	echo "$1 proccess is not running" >> $LOG_FILES_LOCATION/unistallation-logs-$DATE.txt
        fi
}

# Function to remove packages
remove_packages() {
        PACKAGE_LIST=$(rpm -qa | grep $1)
        for package in $PACKAGE_LIST;
        do
                echo "removing PACKAGE of $1" >> $LOG_FILES_LOCATION/unistallation-logs-$DATE.txt
                rpm -e "$package"
        done
}

#define directory to store the logs
if [ ! -d "$LOG_FILES_LOCATION" ]; then
        # Create the directory if it doesn't exist
        mkdir -p "$LOG_FILES_LOCATION"
fi

#take tha backup of the dsm.sys and dsm.opt files.
echo "Taking backup of important files" >> $LOG_FILES_LOCATION/unistallation-logs-$DATE.txt
cp -p /home/ec2-user/timestamp.txt /tmp/timestamp-$DATE.txt
# cp -p /opt/tivoli/tsm/client/ba/bin/dsm.opt /tmp/dsm.opt-$DATE

kill_process kibana
remove_packages kibana

# #kill the process for dsmcad
# kill_process dsmcad
# remove_packages GSK 


