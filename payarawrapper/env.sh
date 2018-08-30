#!/bin/sh


# asadmin variables
AS_HOME=/opt/payara41
AS_ADMIN_USER=admin
AS_ADMIN_PASSWORDFILE=/opt/.aspasswd
AS_ADMIN_HOST=localhost

# jdbc connection env
PYR_JDBC_CONN_URL='xxxxx' # without this the setup will fail
PYR_JDBC_CONN_PASSWORD='xxxxx' 

# Path variable
PATH=${PATH}:${AS_HOME}/bin

export PATH AS_HOME AS_ADMIN_USER AS_ADMIN_HOST AS_ADMIN_PASSWORDFILE \
       PYR_JDBC_CONN_URL PYR_JDBC_CONN_PASSWORD
