FROM bonita:2021.1

ENV URL_PAGES https://github.com/alexjcm/certificacion-electronica-recursos/raw/main/01_paginas/bonita-pages
ENV PATH_BONITA_SERVER /opt/bonita/BonitaCommunity-2021.1/server

RUN cd $HOME \
    && curl -O $URL_PAGES/login.jsp \
    && mv $HOME/login.jsp $PATH_BONITA_SERVER/webapps/bonita \
    && curl -O $URL_PAGES/error-pages/403.jsp \
    && curl -O $URL_PAGES/error-pages/404.jsp \
    && curl -O $URL_PAGES/error-pages/500.jsp \
    && mv $HOME/*.jsp $PATH_BONITA_SERVER/webapps/bonita/error-pages \
    && sed -i "s/defaultTimeout\">180/defaultTimeout\">300/" "$PATH_BONITA_SERVER"/conf/jbossts-properties.xml
    
# Increase the default transaction timeout of XA from 180 to 300 with sed command:
# <entry key="com.arjuna.ats.arjuna.coordinator.defaultTimeout">180</entry>
# <entry key="com.arjuna.ats.arjuna.coordinator.defaultTimeout">300</entry>
