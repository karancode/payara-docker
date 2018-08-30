#!/bin/sh

# asadmin env
AS_HOME=/opt/payara41
AS_ADMIN_USER=admin
AS_ADMIN_PASSWORDFILE=/opt/.aspasswd
AS_ADMIN_HOST=localhost

PATH=${PATH}:${AS_HOME}/bin

export PATH AS_HOME AS_ADMIN_USER AS_ADMIN_PASSWORDFILE AS_ADMIN_HOST
