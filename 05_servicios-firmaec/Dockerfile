FROM jboss/base-jdk:8

ENV WILDFLY_VERSION 20.0.1.Final
ENV WILDFLY_SHA1 95366b4a0c8f2e6e74e3e4000a98371046c83eeb
ENV JBOSS_HOME /opt/wildfly
# ENV JAVA_OPTS=" -Xms784m -Xmx784m -XX:MetaspaceSize=784m -XX:MaxMetaspaceSize=784m -Djava.net.preferIPv4Stack=true"
ENV JBOSS_STATIC /opt/wildfly-static

ENV DATASOURCE_NAME FirmaDigitalDS
ENV DATASOURCE_JNDI java:/FirmaDigitalDS

ARG DB_USER
ARG DB_PASS
ARG DB_NAME
ARG ADMIN_WILDFLY
ENV DB_HOST localhost
ENV DB_PORT 5432
ENV DB_USER ${DB_USER}
ENV DB_PASS ${DB_PASS}
ENV DB_NAME ${DB_NAME}

USER root
RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

RUN mkdir -p ${JBOSS_STATIC} \
    && chown -R jboss:0 ${JBOSS_STATIC} \
    && chmod -R g+rw ${JBOSS_STATIC}
    
# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER jboss
COPY /scripts/config.sh /scripts/
COPY standalone.xml $JBOSS_HOME/standalone/configuration/ 
COPY api.war $JBOSS_HOME/standalone/deployments/
COPY recepcion.war $JBOSS_HOME/standalone/deployments/
ADD https://jdbc.postgresql.org/download/postgresql-42.2.2.jar /tmp/

USER root
RUN chown -R jboss:0 /scripts \
    && chmod +x /scripts/config.sh \
    && chown jboss:0 /tmp/postgresql-42.2.2.jar

USER jboss
# Start, config and shutdown Wildfly
RUN /scripts/config.sh
RUN $JBOSS_HOME/bin/add-user.sh ${ADMIN_WILDFLY} ${ADMIN_WILDFLY} --silent

# WARN: Could not rename /opt/wildfly/standalone/configuration/standalone_xml_history/current 
# to /opt/wildfly/standalone/configuration/standalone_xml_history/
RUN rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/current

COPY /no-descarga-crl/servicio.war $JBOSS_HOME/standalone/deployments/
# COPY /descarga-crl/servicio.war $JBOSS_HOME/standalone/deployments/

#EXPOSE 8080

#Starting WildFly in management mode
CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

