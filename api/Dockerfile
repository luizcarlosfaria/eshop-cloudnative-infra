FROM kong:3.0.0-alpine

COPY ./kong.yml /

USER root

RUN cp /etc/kong/kong.conf.default /etc/kong/kong.conf && echo 'dns_order=LAST,A,CNAME' >> /etc/kong/kong.conf

USER kong