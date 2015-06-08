#!/bin/bash
# Tim Quinn - mstrtimespace@gmail.com
# Script to scrape data out of puppet log file
# used with no arguements, just run script.

logfile="puppet_access_ssl.log"
sshd_fetch=`grep sshd_config $logfile|wc -l`
logfile_count=`wc -l $logfile`
count_200=`grep " 200 " $logfile|wc -l`
count_404=`grep " 404 " $logfile|wc -l`
count_puts=`grep "PUT" $logfile|grep "/dev/report/"|wc -l`
unique_puts=`grep "PUT" $logfile|grep "/dev/report"|cut -d " " -f 1|uniq`
echo "sshd_config was fetched $sshd_fetch times"
echo "You recieved a status of \"200\" $count_200 times"
echo "Out of $logfile_count connections, $count_404 were not successful"
echo "You had $count_puts uploads to the /dev/report directory"
for i in $unique_puts; do
  echo "$i connected `grep $i $logfile|grep "/dev/report/"|wc -l` time(s)";
done
