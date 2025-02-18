FROM mhart/alpine-node:10

##
## S6 Overlay && go-dnsmasq
## https://github.com/janeczku/docker-alpine-kubernetes/blob/master/versions/3.3/Dockerfile
##

ENV S6_VERSION=v1.22.1.0 GODNSMASQ_VERSION=1.0.7

RUN apk add --update wget \
	&& wget https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz --no-check-certificate --quiet -O /tmp/s6-overlay.tar.gz \
	&& wget https://github.com/janeczku/go-dnsmasq/releases/download/${GODNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 --no-check-certificate --quiet -O /usr/sbin/go-dnsmasq \
	&& chmod +x /usr/sbin/go-dnsmasq \
	&& tar xvfz /tmp/s6-overlay.tar.gz -C / \
	&& rm -f /tmp/s6-overlay.tar.gz \
	&& apk del wget \
	&& rm -rf /var/cache/apk/*

##
## RootFS
##

COPY rootfs /

##
## Init
##

ENTRYPOINT ["/init"]
