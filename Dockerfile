FROM jefferyb/polymer-cli:latest

USER root

COPY nginx.list /etc/apt/sources.list.d/nginx.list
COPY nginx_signing.key /tmp/nginx_signing.key

RUN apt-key add /tmp/nginx_signing.key && \
    apt-get update && \
    apt-get install -y --no-install-recommends nginx && \
    apt-get clean

CMD bash