#FROM nginx:1.22-alpine
from ghcr.io/zvonimirsun/nginx:stable-alpine-brotli

ARG BUILDNUMBER
ARG DOCKER_BUILD_ARGS_ENV
ARG NGINX_ENVIRONMENT=docker

ENV BUILD_NUMBER=${BUILDNUMBER}

COPY web-app/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY web-app/nginx/nginx.conf /etc/nginx/nginx.conf
COPY web-app/dist /usr/share/nginx/html

USER root
RUN chown nginx:nginx /usr/share/nginx/html/*
RUN chown nginx:nginx /usr/share/nginx/html
RUN chmod 775 /usr/share/nginx/html
RUN mkdir /var/cache/nginx/client_temp
RUN chown nginx:nginx /var/cache/nginx
RUN chown nginx:nginx /var/cache/nginx/*
RUN touch /var/run/nginx.pid
RUN chown nginx:nginx /var/run/nginx.pid
USER nginx

EXPOSE 443
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]