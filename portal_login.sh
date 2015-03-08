#!/bin/sh
# a shellscript for login to www.portal.fudan.edu.cn
# arguments      : [studentid] [password]
# return value   : 0 means login successful
#                  1 means login failed
# reqiured tools : wget grep

# set variables
stuid=$1
password=$2

# get jsessionid
if ! wget -q -O '/dev/null' --load-cookies cookies.txt --save-cookies cookies.txt --keep-session-cookies 'http://www.portal.fudan.edu.cn/main/loginIndex.do?ltype=1'; then
    exit 1
fi

# login to portal
errurl=`wget -O '/dev/null' --load-cookies cookies.txt --save-cookies cookies.txt --keep-session-cookies 'http://www.portal.fudan.edu.cn/main/login.do?invitationCode=' --post-data "email=$stuid&password=$password" --max-redirect=0 2>&1 | grep error`
if [ "$errurl" != "" ]; then
    exit 1
fi

exit 0

