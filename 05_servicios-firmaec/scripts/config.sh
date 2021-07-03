#!/bin/bash

JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh

function wait_for_server() {
  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
    echo "Waiting..."
    sleep 6
  done
}

echo "=> Starting WildFly Server..."
$JBOSS_HOME/bin/standalone.sh -b=0.0.0.0 -c standalone.xml > /dev/null &

echo "=> Waiting for the server to boot..."
wait_for_server

echo "=> Setup Datasource..."
$JBOSS_CLI -c  << EOF
batch
# 1. Add PostgreSQL driver
module add --name=org.postgresql --resources=/tmp/postgresql-42.2.2.jar --dependencies=javax.api,javax.transaction.api
/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql,driver-xa-datasource-class-name=org.postgresql.xa.PGXADataSource)
# 2. Add the datasource
data-source add \
  --name=$DATASOURCE_NAME \
  --jndi-name=$DATASOURCE_JNDI \
  --connection-url=jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME \
  --driver-name=postgresql \
  --user-name=$DB_USER \
  --password=$DB_PASS \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter 
# 3. Execute the batch
run-batch
EOF

echo "=> Shutdown Wildfly..."
$JBOSS_CLI -c ":shutdown"


# echo "=> Starting WildFly in management mode"
# $JBOSS_HOME/bin/standalone.sh -b=0.0.0.0 -bmanagement=0.0.0.0 --debug

