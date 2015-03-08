#!/bin/sh
# login to pt and portal, then bind pt with tac verification - the main shellscript
# return value   : 0 means successful
#                  1 means failed

# provide your information
portal_stuid=PUT_YOUR_STUDENT_ID_HERE
portal_password=PUT_YOUR_PORTAL_PASSWORD_HERE
pt_username=PUT_YOUR_FDUPT_USERNAME_HERE
pt_password=PUT_YOUR_FDUPT_PASSWORD_HERE

# first, login to pt
echo -n 'login to pt.vm.fudan.edu.cn ... '
if ./pt_login.sh "$pt_username" "$pt_password"; then echo 'ok'; else echo 'failed'; exit 1; fi

# second, login to portal
echo -n 'login to www.portal.fudan.edu.cn ... '
if ./portal_login.sh "$portal_stuid" "$portal_password"; then echo 'ok'; else echo 'failed'; exit 1; fi

# finally, bind pt
echo -n 'bind pt with tac verification ... '
if ./pt_bind.sh; then echo 'ok'; else echo 'failed'; exit 1; fi

exit 0

