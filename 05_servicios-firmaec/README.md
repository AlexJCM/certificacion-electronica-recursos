#### Logs
Docker almacena los logs de forma predeterminada en un archivo de registro. Para comprobar la ruta de dicho ejecutar el comando:
docker inspect --format='{{.LogPath}}' containerName
Para ver los registros en vivo, puede ejecutar el siguiente comando:
tail -f `docker inspect --format='{{.LogPath}}' containerName`

## Guardando los logs de forma persistente:
¿Y si quisiera guardar los logs de forma persistente? Ahora mismo si paro mi contenedor pierdo todo el contenido… Podemos lograrlo mapeando el sistema de ficheros del docker con el host con la opción -v (volumen), de manera que se escriba en el directorio /var/log/wildfly/example de nuestro host el contenido de /opt/wildfly/standalone/log del contenedor.

docker run --name example -p 8180:8080 -v /var/log/wildfly:/opt/wildfly/standalone/log app-war


# El servidor se ejecuta como el usuario jboss que tiene el uid/gid configurado en 1000.
sudo groupadd -r jboss
sudo useradd -r -g jboss -s /sbin/nologin jboss
#useradd -u 1000 -r -g jboss -m -d /var/log/wildfly -s /sbin/nologin -c "JBoss user" jboss
sudo mkdir /var/log/wildfly
sudo chown jboss:jboss /var/log/wildfly
# chmod 755 /var/log/wildfly

# sudo useradd -r -g jboss -d  /var/log/wildfly -s  /sbin/nologin jboss

Ahora paramos el docker:
docker stop wildfly-example

Vemos que el log es persistente y de hecho Wildfly habrá parado de forma ordenada cuando ordenamos parar al contenedor:
/var/log/jboss$ tail server.log 

--------------------------
## Crear Volúmen (-v <ruta_anfitrión>:<ruta_contenedor>)
----#1
Otro ejemplo sería, si ejecutamos en una terminal:
docker run -i -t -v ~/archivos_de_proyecto:/proyecto ubuntu:16.04 /bin/bash
# Donde la carpeta ~/archivos_de_proyecto existe en nuestro sistema anfitrión, entonces un enlace es creado hacia el contenedor.
# Para comprobarlo, creamos un archivo prueba.txt en nuestra carpeta local, y comprobamos si se mapea automaticamente al contenedor y viceversa.

Si quisiéramos, en lugar de especificar el volumen en el comando de inicio con la bandera -v podríamos ponerlo en nuestro DOCKEFILE

----#2
docker run --rm --name example -p 8080:8080 -v /opt/wildfly-static:/opt/wildfly-static  app-war


## Reiniciar automáticamente contenedor al reinicar sistema
#docker run --restart="always" <CONTAINER ID> .....

# Si ya está iniciado el contenedor, puede usar el siguiente comando:
#docker update --restart=always <CONTAINER ID> ...


---------------------------------------
## WildFly Docker - Despliegue de aplicaciones
Con el servidor WildFly puede implementar su aplicación de varias formas:
- Puedes usar CLI
- Puedes usar la consola web
- Puede utilizar el escáner de implementación

La forma más popular de implementar una aplicación es utilizar el escáner de implementación. En WildFly, este método está habilitado de forma predeterminada y lo único que debe hacer es colocar su aplicación dentro del directorio deployments/. 

Se preparó un ejemplo (https://github.com/goldmann/wildfly-docker-deployment-example) simple para mostrar cómo hacerlo, pero los pasos son los siguientes:
1. Crea Dockerfile con el siguiente contenido:
 FROM jboss/wildfly
 ADD archivo.war /opt/wildfly/standalone/deployments/
2. Coloque su archivo.war en el mismo directorio que su Dockerfile.
3. Ejecute la compilación con: docker build --t wildfly-app .
4. Ejecute el contenedor con: docker run -it -p 8180:8180  wildfly-app. La aplicación se implementará en el inicio del contenedor.

## Logs
El registro se puede realizar de muchas formas. Esta publicación (https://goldmann.pl/blog/2014/07/18/logging-with-the-wildfly-docker-image/) describe muchos de ellos.

## Personalización de la configuración
A veces es necesario personalizar la configuración del servidor de aplicaciones. Hay muchas formas de hacerlo y esta publicación (https://goldmann.pl/blog/2014/07/23/customizing-the-configuration-of-the-wildfly-docker-image/) intenta resumirlo.

----------------------------
# Deploying web applications on WildFly
docker cp /path/to/app.war wildfly-container:/app.war




