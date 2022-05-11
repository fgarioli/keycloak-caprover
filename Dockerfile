ARG KC_VERSION=17.0.0

FROM quay.io/keycloak/keycloak:${KC_VERSION} as builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=admin-fine-grained-authz,token-exchange,upload-scripts
ARG KC_DB=${KC_DB}
ENV KC_DB=$KC_DB

# Install custom providers
RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/2.5.3/keycloak-metrics-spi-2.5.3.jar -o /opt/keycloak/providers/keycloak-metrics-spi-2.5.3.jar
COPY ./providers/. /opt/keycloak/providers/
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:${KC_VERSION}
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak

# change these values to point to a running postgres instance
ARG KC_DB_URL_HOST=${KC_DB_URL_HOST}
ENV KC_DB_URL_HOST=$KC_DB_URL_HOST

ARG KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_USERNAME=$KC_DB_USERNAME

ARG KC_DB_PASSWORD=${KC_DB_PASSWORD}
ENV KC_DB_PASSWORD=$KC_DB_PASSWORD

ENV KC_PROXY=edge
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false

COPY ./themes/. themes/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]