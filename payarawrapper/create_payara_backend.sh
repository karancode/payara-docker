#!/bin/sh

# --- #

set -euf  #-o pipefail

# load commons
. /opt/scripts/common_asadmin_env.sh

# load env
. /opt/scripts/load_env.sh

#printenv 

#touch /opt/.tmppasswd
#touch /opt/.aspasswd

#echo "AS_ADMIN_PASSWORD=\n"
#echo "AS_ADMIN_NEWPASSWORD=5aifu" >> /opt/.tmppasswd

#cat /opt/.tmppasswd

#echo "AS_ADMIN_PASSWORD=5aifu" >> /opt/.aspasswd
#echo "AS_ADMIN_MASTERPASSWORD=changeit" >> /opt/.aspasswd

#cat /opt/.aspasswd
# Start Domain
#asadmin --user $AS_ADMIN_USER --passwordfile=/opt/tmpfile change-admin-password

AS_ADMIN_PASSWORDFILE=/opt/.aspasswd
export AS_ADMIN_PASSWORDFILE

#cat $AS_ADMIN_PASSWORDFILE
#cat /opt/.aspasswd

#asadmin start-domain domain1
#asadmin --user $AS_ADMIN_USER --passwordfile=/opt/.aspasswd  enable-secure-admin
#asadmin  restart-domain domain1
#asadmin list-domains --long

# start domain
asadmin start-domain domain1
#
#mkdir -p /opt/deployments
#cp ./showcase-5.3.war /opt/deployments

# Create access-log config
#asadmin get "*" | grep access-logging-enabled

#asadmin set configs.config.server-config.http-service.access-logging-enabled=false
#asadmin set configs.config.server-config.http-service.access-logging-enabled=true
#asadmin set configs.config.server-config.http-service.access-logging-enable=true
#asadmin set configs.config.server-config.http-service.access-log.format="%client.name% %auth-user-name% %datetime% %request% %status% %response.length% %time-taken% %user-agent%"
#asadmin set configs.config.server-config.http-service.access-log.write-interval-seconds=1

# Create http config
asadmin set configs.config.server-config.network-config.network-listeners.network-listener.http-listener-1.port=$PYR_INSTANCE_LISTEN_PORT
asadmin set configs.config.server-config.thread-pools.thread-pool.http-thread-pool.min-thread-pool-size=$PYR_INSTANCE_HTTP_MAX_POOLSIZE 
asadmin set configs.config.server-config.thread-pools.thread-pool.http-thread-pool.max-thread-pool-size=$PYR_INSTANCE_HTTP_MIN_POOLSIZE

# Create jvm-option configs
asadmin delete-jvm-options --target=server-config '-Xmx512m'
asadmin create-jvm-options --target=server-config '-Xmx2048m'
asadmin create-jvm-options --target=server-config '-Xms2048m'


# Create GC configs
#asadmin create-jvm-options --target=server-config '-Xloggc\:${com.sun.aas.instanceRoot}/logs/gc_%t.log'
#asadmin create-jvm-options --target=server-config '-XX\:+UseGCLogFileRotation'
#asadmin create-jvm-options --target=server-config '-XX\:HeapDumpPath=${com.sun.aas.instanceRoot}/logs/heapdump.hprof'
#asadmin create-jvm-options --target=server-config '-XX\:+PrintGCDetails'
#asadmin create-jvm-options --target=server-config '-XX\:+HeapDumpOnOutOfMemoryError'
#asadmin create-jvm-options --target=server-config '-XX\:+PrintGCDateStamps'
#asadmin create-jvm-options --target=server-config '-verbose\:gc'
#asadmin create-jvm-options --target=server-config '-XX\:GCLogFileSize=0'
#asadmin create-jvm-options --target=server-config '-XX\:NumberOfGCLogFiles=3'
#asadmin create-jvm-options --target=server-config '-XX\:+DisableExplicitGC'

# Add mjdbc-driver & restart domain
#cp ./$PYR_MJDBC_JAR_FILE_NAME $PYR_HOME/glassfish/domains/domain1/lib/ext --> needs to be done in "Dockerfile"

#asadmin restart-domain
#asadmin list-domains --long
#-> DO NOT NEED THIS AS IT'S DONE IN DockerFILE before starting the domain!

# Create jdbc-conn-pool
asadmin create-jdbc-connection-pool --datasourceclassname com.mysql.jdbc.jdbc2.optional.MysqlXADataSource  \
       --resType javax.sql.XADataSource \
       --steadypoolsize $PYR_JDBC_CONNPOOL_MINSIZE \
       --maxpoolsize $PYR_JDBC_CONNPOOL_MAXSIZE \
       --property user=$PYR_JDBC_CONN_USER:password=$PYR_JDBC_CONN_PASSWORD:url="$PYR_JDBC_CONN_URL":driverClass='com.mysql.jdbc.Driver' \
       $PYR_JDBC_CONNPOOL_NAME

# Jdbc connection ping --> cannot ping from local!!! ENABLE LATER FOR REAL ENV
#asadmin ping-connection-pool $PYR_JDBC_CONNPOOL_NAME

# Create Jdbc resource & ref
asadmin create-jdbc-resource --connectionpoolid $PYR_JDBC_CONNPOOL_NAME $PYR_JDBC_CONNRES_NAME

#asadmin create-resource-ref --enabled=true --target=server $PYR_JDBC_CONNRES_NAME
#--> NO NEED REF AS IT IS ALREADY CREATED FOR TARGET 'server'

# Java Mail Session
asadmin create-javamail-resource --mailhost=$PYR_JMAIL_MAILHOST --mailuser=$PYR_JMAIL_MAILUSER --fromaddress=$PYR_JMAIL_FROMADDRESS --storeprotocol=imap --storeprotocolclass=com.sun.mail.imap.IMAPStore --transprotocol=smtp --transprotocolclass=com.sun.mail.smtp.SMTPTransport $PYR_JMAIL_JNDI_NAME

# App deploy
asadmin deploy --type war --enabled --name primefaceShowcaseApp --contextroot / /opt/deployments/showcase-5.3.war  

asadmin list-applications --long

# Start Instance
#asadmin start-instance $PYR_INSTANCE_NAME
#asadmin list-instances --long 

#end
