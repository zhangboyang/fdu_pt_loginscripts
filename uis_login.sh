#!/bin/sh
# a shellscript for login to uis2.fudan.edu.cn
# arguments      : [studentid] [password]
# return value   : 0 means login successful
#                  1 means login failed
# reqiured tools : wget grep

# set variables
stuid="$1"
password="$2"

# get jsessionid
if ! wget -q -O '/dev/null' --save-cookies cookies.txt --keep-session-cookies 'https://uis2.fudan.edu.cn/amserver/UI/Login'; then
    exit 1
fi

# login to uis
errurl=`wget -O '/dev/null' --load-cookies cookies.txt --save-cookies cookies.txt --keep-session-cookies 'https://uis2.fudan.edu.cn/amserver/UI/Login' --post-data "IDToken0=&IDToken1=$stuid&IDToken2=$password&IDButton=Submit&goto=&encoded=false&inputCode=&gx_charset=UTF-8" --max-redirect=0 2>&1 | grep error`
if [ "$errurl" != "" ]; then
    exit 1
fi

exit 0

