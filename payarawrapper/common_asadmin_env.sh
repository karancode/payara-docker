#!/bin/sh

AS_HOME=/opt/payara41
AS_ADMIN_USER=admin
#AS_ADMIN_PASSWORDFILE=/opt/.aspasswd
AS_ADMIN_HOST=localhost

#touch /opt/.aspasswd
#echo "AS_ADMIN_PASSWORD=admin" >> /opt/.aspasswd
#echo "AS_ADMIN_MASTERPASSWORD=changeit" >> /opt/.aspasswd

PATH=${PATH}:${AS_HOME}/bin

export PATH AS_HOME AS_ADMIN_USER AS_ADMIN_HOST #AS_ADMIN_PASSWORDFILE AS_ADMIN_HOST
