#!/bin/bash
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_FILE_CONFIG=$JBOSS_HOME/standalone/configuration/standalone.xml

function wait_for_server() {
  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
    echo "Waiting..."
    sleep 6
  done
}

echo "--------  Setup wilfly-static directory ----------"
sed -i '/<location name="\/" handler="welcome-content"\/>/a \                    <location name="\/static" handler="dirPdfs"\/>' "$JBOSS_FILE_CONFIG"
sed -i '/<file name="welcome-content" path="${jboss.home.dir}\/welcome-content"\/>/a \                <file name="dirPdfs" path="\/opt\/wildfly-static"\/>' "$JBOSS_FILE_CONFIG"

echo "--------  Chenge http port from 8080 to 7776 ----------"
sed -i "s/jboss.http.port:8080/jboss.http.port:7776/" "$JBOSS_FILE_CONFIG"

echo "----------- Starting WildFly Server -------------"
$JBOSS_HOME/bin/standalone.sh -b=0.0.0.0 -c standalone.xml > /dev/null &
wait_for_server

echo "------------  Setup Datasource   ---------------"
$JBOSS_CLI -c << EOF
batch
module add --name=org.postgresql --resources=$HOME/postgresql-42.2.13.jar --dependencies=javax.api,javax.transaction.api
/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql,driver-xa-datasource-class-name=org.postgresql.xa.PGXADataSource)

data-source add \
  --name=$DATASOURCE_NAME \
  --jndi-name=$DATASOURCE_JNDI \
  --connection-url=jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME_SIGNATURE} \
  --driver-name=postgresql \
  --user-name=$DB_USER_SIGNATURE \
  --password=$DB_PASS_SIGNATURE \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter

run-batch
EOF

echo "------------  Setup JWT KEY   ---------------"
# Previously a JWT key must have been generated manually by executing the Class: ServicioTokenJwt.java
$JBOSS_CLI -c << EOF
batch
/system-property="jwt.key":add(value="${JWT_KEY_SIGNATURE}")
run-batch
EOF

echo "------------  Shutdown Wildfly  -------------"
$JBOSS_CLI -c ":shutdown"
