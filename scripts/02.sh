#!/bin/bash
crontab -l > cronfile
echo "0 4 * * 0 apt-get update >> /var/log/update_script.log && apt-get upgrade >> /var/log/update_script.log" >> cronfile
crontab cronfile
rm cronfile
