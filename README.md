[![](https://images.microbadger.com/badges/version/philipjkim/polymer-cli-nginx.svg)](http://microbadger.com/images/philipjkim/polymer-cli-nginx "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/philipjkim/polymer-cli-nginx.svg)](http://microbadger.com/images/philipjkim/polymer-cli-nginx "Get your own image badge on microbadger.com")


## philipjkim/polymer-cli-nginx

This image is based on [jefferyb/polymer-cli](https://hub.docker.com/r/jefferyb/polymer-cli/), with Nginx installed for the production use for Polymer web apps.


## Supported tags

-	[`latest` (*Dockerfile*)](https://github.com/philipjkim/docker-polymer-cli-nginx/blob/master/Dockerfile)


## Usage Example

### `Dockerfile`

```text
FROM philipjkim/polymer-cli-nginx:latest

USER root

COPY conf/nginx/nginx.conf /etc/nginx/nginx.conf
COPY . /opt/your-polymer-app

WORKDIR /opt/your-polymer-app

RUN bower install --allow-root
RUN polymer build

EXPOSE 80

CMD ["nginx"]

```

### `conf/nginx/nginx.conf`

```text
worker_processes  4;
user root;
daemon off;
error_log /dev/stdout info;

events {
    worker_connections  1024;
}

http {
    access_log /dev/stdout;

    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    sendfile        on;
    keepalive_timeout  65;
    gzip  on;

    server {
        listen 80;
        root /opt/your-polymer-app/build/bundled;
        index index.html;

        location /
        {
            try_files $uri /index.html;
        }
    }
}

```