#!/bin/bash
func()
{
clear
echo "******************************"
echo Welcome to Nmap-Hydra Script :
echo "******************************"
echo
echo -n "Enter the Network you want to scan (Ex. 10.0.0.1/8,10.0.0.1-200): "
read v1
echo -n "Enter Service name (Ex: ftp or ssh or http-get or http-form-post ): "
read v5
echo -n "Enter Port you want to scan (Ex. 21 OR 22 OR 80 etc.): "
read v2
echo -n  "Enter File name in which your targets IP will be copied (for default file i.e. nmaphydrafile.txt press 'd'): "
read v
if [ $v == d ]
then
	var=nmaphydrafile.txt
else var=$v
fi
echo
echo Be Patient !!! We are scanning live hosts for your network ...
nmap -p $v2 -oG nmaphydrafile1 $v1 > /dev/null
cat nmaphydrafile1 | grep $v2/open | awk '{print $2}' >$var
rm nmaphydrafile1
echo -n "Do you want to use (D)efault username-wordlist or enter (M)anually : "
read v10;
if [ $v10 == D -o $v10 == d ]
then
	v3=usernames.txt

else
 echo -n Enter location of usernames wordlist :
 read v3
fi
echo -n "Do you want to use (D)efault password-wordlist or enter (M)anually : "
read v11;
if [ $v11 == D -o $v11 == d ]
then
	v4=pass.txt
else
 echo -n Enter location of password wordlist :
 read v4
fi
echo -n "Enter File name where cracked username passwords will be saved (for default file i.e. nmaphydrafile2.txt press 'd'): "
read v7
if [ $v7 == d ]
then
	var2=nmaphydrafile2.txt
else var2=$v7
fi


clear
echo Your command is ready : 
echo
echo "hydra -L $v3 -P $v4 -s $v2 -o $var2 -M $var $v5 "
echo
echo -n "Do you want to continue (y/n) ?"
read v6
clear
if [ $v6 == y -o $v6 == Y ]
then
hydra -L $v3 -P $v4 -s $v2 -o $var2 -M $var $v5
else 
	echo -n Press q to exit or r to continue :
	read v6
	if [ $v6 == q -o $v6 == Q ]
	then
	exit
else func
fi
fi
}
func
