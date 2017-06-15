#!/bin/bash

while [ 1 ]
do
    rsync -avz --partial --progress $1 $2
    if [ "$?" = "0" ] ; then
        echo "rsync completed normally"
        exit
    else
        echo "Rsync failure. Backing off and retrying..."
        sleep 180
    fi
done