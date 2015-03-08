#!/bin/sh
# a shellscript for login to pt.vm.fudan.edu.cn
# arguments      : [username] [password]
# return value   : 0 means login successful
#                  1 means login failed
# reqiured tools : cut grep wget sha1sum

# set variables
username=$1
password=$2

# calc hash_password
first_half=`echo -n "$username$password" | sha1sum | cut -d \  -f 1`
second_half=`wget -q -O - --save-cookies cookies.txt --keep-session-cookies 'http://pt.vm.fudan.edu.cn/index.php' | grep 'form action' | cut -d \' -f 2`
hash_password=`echo -n "$first_half$second_half" | sha1sum | cut -d \  -f 1`
if [ "$second_half" = "" ]; then exit 1; fi

# login to pt, max-redirect limit exceed means login successful
if wget -q -O '/dev/null' --load-cookies cookies.txt --save-cookies cookies.txt --keep-session-cookies 'http://pt.vm.fudan.edu.cn/index.php?action=login2' --post-data "user=$username&passwrd=&cookielength=1440&hash_passwrd=$hash_password" --max-redirect=0; then
    exit 1
fi

exit 0

