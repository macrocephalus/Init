#!/bin/bash
echo "
rez=\"OK\"

crontab -l > /home/\$USER/crotab.temp
if [ ! -f "/home/\$USER/rezmd5.txt" ];
then
	md5sum /home/\$USER/crotab.temp > /home/\$USER/rezmd5.txt
fi

mdsumr=\$(md5sum -c /home/\$USER/rezmd5.txt | awk '{print \$2}')
echo \$mdsumr

if [[ \$rez = \$mdsumr ]]
then
	echo "ne zmin"
	echo \"file crontab ne zminuvabsia\" | sudo sendmail root
else
	echo "zmin"
	echo \"file crontab zminuvabsia\" | sudo sendmail root
fi
crontab -l > /home/\$USER/crotab.temp
md5sum /home/\$USER/crotab.temp > /home/\$USER/rezmd5.txt
exit 0" >/home/$USER/script04.sh

crontab -l > mycron

if grep "/home/\$USER/script04.sh" mycron;
then
	echo "e v crontab"
else
	echo "nema v crontab"

	echo "00 00 * * * /home/\$USER/script04.sh" >> mycron
	crontab mycron
fi
#echo $cronadd
rm mycron

bash /home/$USER/script04.sh #v konce
exit 0