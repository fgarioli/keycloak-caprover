```shell
KC_DB=postgres
KC_DB_URL_HOST=db_host
KC_DB_USERNAME=db_username
KC_DB_PASSWORD=db_password
KEYCLOAK_ADMIN=keycloak_admin_user
KEYCLOAK_ADMIN_PASSWORD=keycloak_admin_password
KC_HOSTNAME=keycloak_url
KC_HOSTNAME_STRICT_BACKCHANNEL=true
JAVA_OPTS=-Xms64m -Xmx512m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true
```

[Reference 1](https://keycloak.discourse.group/t/keycloak-17-run-in-docker-behind-nginx-reverse-proxy/13862/2)\
[Reference 2](https://keycloak.discourse.group/t/differences-between-keycloak-and-keycloak-x-docker-images/9459/5)

Old Config:
```shell
DB_VENDOR=postgres
DB_ADDR=db_host
POSTGRES_DB=keycloak
DB_USER=keycloak
DB_PASSWORD=db_password
KEYCLOAK_USER=keycloak_admin_user
KEYCLOAK_PASSWORD=keycloak_admin_password
PROXY_ADDRESS_FORWARDING=true
JAVA_OPTS=-server -Xms256m -Xmx1024m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true -Djboss.modules.system.pkgs=org.jboss.byteman -Djava.awt.headless=true
JAVA_OPTS_APPEND="-Dkeycloak.profile.feature.upload_scripts=enabled -Dkeycloak.profile.feature.admin_fine_grained_authz=enabled\n-Dkeycloak.profile.feature.admin2=enabled"
```