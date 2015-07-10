#!/bin/sh
# a shellscript for bind pt using tac verification
# requirements   : already login to pt and uis, cookies saved in cookies.txt
# reqiured tools : grep wget

# get redirecturl, if redirecturl is not empty means succeed
redirecturl=`wget -O '/dev/null' --load-cookies cookies.txt --save-cookies cookies.txt --keep-session-cookies 'https://tac.fudan.edu.cn/thirds/ptbind.act' --max-redirect=1 2>&1 | grep 'pt\.vm\.fudan\.edu\.cn'`
if [ "$redirecturl" = "" ]; then
    exit 1
fi

exit 0

