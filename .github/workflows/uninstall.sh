#!/bin/bash

#Logon To system as root
#ssh
#

# Function to kill processes named "dsmc" and "dsmcad" using "killall"
kill_kibana() {
    if killall -q kibana; then
        echo "Killed processes named 'kibana' using 'killall'."
    else
        echo "No 'kibana' processes found with 'killall'."
    fi

    # if killall -q dsmcad; then
    #     echo "Killed processes named 'dsmcad' using 'killall'."
    # else
    #     echo "No 'dsmcad' processes found with 'killall'."
    }

# Main script for kill funtion

echo "Attempting to kill processes named 'kibana'"

kill_kibana


#Check for previously installed packages with these commands

        echo "Checking for kibana packages"

kibana_packages=$(rpm -qa | grep kibana)

        echo "$kibana_packages"

#         echo "Checking for gsk packages"

# tiv_packages=$(rpm -qa | grep TIV)

#         echo "$gsk_packages"



#Uninstall the previous funtion we found from previous step

        for packages in $kibana_packages
                do 
                        rpm -e $kibana_packages
                done

        # for packages in $gsk_packages
        #         do 
        #                 rpm -e $gsk_packages
        #         done        

#
