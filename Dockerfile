FROM quay.io/keycloak/keycloak:18.0.0 as builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=admin-fine-grained-authz,token-exchange,scripts
ARG KC_DB=${KC_DB}
ENV KC_DB=$KC_DB
# Install custom providers
RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/2.5.3/keycloak-metrics-spi-2.5.3.jar -o /opt/keycloak/providers/keycloak-metrics-spi-2.5.3.jar
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:18.0.0
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak
# for demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
# change these values to point to a running postgres instance

ARG KC_DB_URL=${KC_DB_URL}
ENV KC_DB_URL=$KC_DB_URL

ARG KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_USERNAME=$KC_DB_USERNAME

ARG KC_DB_PASSWORD=${KC_DB_PASSWORD}
ENV KC_DB_PASSWORD=$KC_DB_PASSWORD

ENV KC_HOSTNAME=localhost

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]