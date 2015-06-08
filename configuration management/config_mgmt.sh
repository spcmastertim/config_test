# Configuration management script
# Takes output from facter -p module and puts it in the script
# test to see if the list was provided, if not exit and ask for the list of machines
if [ $# -eq 0 ]
then echo "Please list the machines you want to fix the configuration on.  You may redirect the contents of a file to the script if you prefer"
  exit 10
fi

# Get the results of facter -p, create temp file, replace entry, upload file, and push results to a file depending on success or failure.
for i in $@;
  do module_new=`ssh $i facter -p module`
    cp ./template.file $i.file
    sed -i s/X/$module_new/ $i.file
    scp ./template.file $i:/etc/widget_file
    exit_stat=$?
    echo "$i exited with $exit_stat" >> results_file.txt
    if [ $exit_stat -ne 0 ];
      then echo "Warning, $i did not complete successfully" >> failed.txt;
      else `rm ./$i.file`
    fi
done
