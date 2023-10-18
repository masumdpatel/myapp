#!/bin/bash

DATE=$(date +"%Y-%m-%d")
LOG_FILES_LOCATION="/opt/deploy_logs"
# Define the paths to the original file and the backup file
DSM_SYS="/home/ec2-user/timesstamp.txt"
DSM_SYS_BACK="/tmp/timestamp-$DATE.txt"


check_and_move_file() {
    if [ -e "$1" ]; then
        echo "The original file already exists. No action needed." >> "$LOG_FILES_LOCATION/installation-logs-$DATE.txt"
    else
        # Move the backup file to the location of the original file
        mv "$2" "$1"
        echo "Moved the backup file to the location of the original file." >> "$LOG_FILES_LOCATION/installation-logs-$DATE.txt"
    fi
}

# Check and move the dsm.sys file
check_and_move_file "$DSM_SYS" "$DSM_SYS_BACK"


#Change directory to /tmp
cd /tmp

#Download the tarball to /tmp
echo "Starting the downloading of package kibana to /tmp" >> $LOG_FILES_LOCATION/installation-logs-$DATE.txt
wget https://artifacts.elastic.co/downloads/kibana/kibana-8.10.3-x86_64.rpm

# Install the TSM backup-archive (B/A) client packages
#echo "Start the Installation of TSM backup-archive (B/A) client packages" >> $LOG_FILES_LOCATION/installation-logs-$DATE.txt
#rpm -i TIVsm-BA.x86_64.rpm TIVsm-BAcit.x86_64.rpm >> $LOG_FILES_LOCATION/installation-logs-$DATE.txt

echo "Starting the installation of kibana" >> $LOG_FILES_LOCATION/installation-logs-$DATE.txt
sudo rpm --install kibana-8.10.3-x86_64.rpm

STATUS=$?
if [[ $STATUS -eq 0 ]]
then 
    echo "Package is installed" >> $LOG_FILES_LOCATION/installation-logs-$DATE.txt
else
    echo "Installation failed" >> $LOG_FILES_LOCATION/installation-logs-$DATE.txt
fi

echo "Starting the process..."
service start kibana >> $LOG_FILES_LOCATION/installation-logs-$DATE.txt

STATUS=$?
if [[ $STATUS -eq 0 ]]
then
    echo "Service Started" >> $LOG_FILES_LOCATION/installation-logs-$DATE.txt
else
    echo "Service failed to start with error code: $STATUS" >> $LOG_FILES_LOCATION/installation-logs-$DATE.txt
fi
# Count the number of Kibana processes running
#kibana_processes=$(ps -ef | grep kibana | wc -l)

# Check if there is more than one Kibana process

#if [[ $kibana_processes -gt 1 ]]; then
#    echo "Kibana service is already running." >> log.txt
#else
#    systemctl start kibana
#    echo "Kibana has been started." >> log.txt
#fi

# Removing the 7 days old log file.
find $LOG_FILES_LOCATION/ -type f -mtime +7 -exec rm -rf {} \;
