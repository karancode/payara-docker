#!/bin/sh

set -euxf
# -e : exit the shell script when any command fails
# -u : like "use strict". if undefined variable is used, show error message
# -x : show each command itself
# -f : disable pathname expansion

# load asadmin env
. /opt/scripts/env.sh

# start domain
asadmin start-domain domain1

# connection-pool setup
asadmin set resources.jdbc-connection-pool.mysql_cafeapi_pool.property.url=${PYR_JDBC_CONN_URL}
asadmin set resources.jdbc-connection-pool.mysql_cafeapi_pool.property.password=${PYR_JDBC_CONN_PASSWORD}
#asadmin flush-connection-pool mysql_cafeapi_pool
#asadmin ping-connection-pool mysql_cafeapi_pool

# app deploy

#asadmin deploy --type war --enabled --name coffeeapi --contextroot / /opt/payara41/deployments/cafeapi.war  

# domain re-start
asadmin stop-domain domain1
asadmin start-domain --watchdog domain1

## end
