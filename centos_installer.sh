#!/bin/bash
#this installer developed by phatblinkie (brian bowen) with the pirl.io team. 
#please help and submit fixes if you have them
clear
#basic steps
#1 check needed rpms to compile
#2 compile pool, repo will be kept up with latest forks, so changes to the rewards should no be needed
#3 ...



#move these functions later to include file
function sleepcounter
{
while [ $sleeptime -gt 0 ]
do 
echo -e $sleeptime
sleep 1
let sleeptime--
done
}


#step1 see if commands are missing, install missing packages
function find_and_fix_missing_rpms
{
installlist=""
wantedbins="gcc which wget make golang nodejs "
for i in $wantedbins
do
which $i 2>/dev/null 1>/dev/null
if [ "$?" != "0" ]; then installlist="$installlist $i "; echo $i not found, adding to install list; sleep 1;  fi
done
echo found need to install $installlist
sleeptime=10
echo "hit control + C to cancel, about to install $installlist in $sleeptime"
sleepcounter
yum install $installlist
}


#double check what was just supposed to be installed hopefully. exit other wise on fail.
function doublecheck_find_and_fix_missing_rpms
{

wantedbins="gcc which wget make golang nodejs "
for i in $wantedbins
do
which $i 2>/dev/null 1>/dev/null
if [ $? = 0 ]; then echo $i found! YEA!; 
else
 echo $i was NOT found, cant proceed, exiting fix manually;
 exit 1
fi
done
}

find_and_fix_missing_rpms
doublecheck_find_and_fix_missing_rpms
