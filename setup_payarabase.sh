#!/bin/sh

# for setting up base payara #

set -euxf
# -e : exit the shell script when any command fails
# -u : like "use strict". if undefined variable is used, show error message
# -x : show each command itself
# -f : disable pathname expansion

# load environment variables

. /opt/scripts/env_payarabase.sh 

# Change admin password
asadmin --user $AS_ADMIN_USER --passwordfile=/opt/tmpfile change-admin-password
asadmin start-domain domain1
asadmin --user $AS_ADMIN_USER --passwordfile=/opt/.aspasswd  enable-secure-admin
asadmin  restart-domain domain1
asadmin list-domains --long

# Set Access Logging
asadmin set configs.config.server-config.http-service.access-logging-enabled=true
asadmin set configs.config.server-config.http-service.access-log.format="%client.name% %auth-user-name% %datetime% %request% %status% %response.length% %time-taken% %user-agent%"
asadmin set configs.config.server-config.http-service.access-log.write-interval-seconds=1

# Create GC configs
asadmin create-jvm-options --target=server-config '-Xloggc\:${com.sun.aas.instanceRoot}/logs/gc_%t.log'
asadmin create-jvm-options --target=server-config '-XX\:+UseGCLogFileRotation'
asadmin create-jvm-options --target=server-config '-XX\:HeapDumpPath=${com.sun.aas.instanceRoot}/logs/heapdump.hprof'
asadmin create-jvm-options --target=server-config '-XX\:+PrintGCDetails'
asadmin create-jvm-options --target=server-config '-XX\:+HeapDumpOnOutOfMemoryError'
asadmin create-jvm-options --target=server-config '-XX\:+PrintGCDateStamps'
asadmin create-jvm-options --target=server-config '-verbose\:gc'
asadmin create-jvm-options --target=server-config '-XX\:GCLogFileSize=0'
asadmin create-jvm-options --target=server-config '-XX\:NumberOfGCLogFiles=3'
asadmin create-jvm-options --target=server-config '-XX\:+DisableExplicitGC'

# Stop domain
asadmin stop-domain domain1
