FROM gliderlabs/alpine
RUN echo "http://alpine.gliderlabs.com/alpine/edge/testing" >> /etc/apk/repositories;\
    apk-install nginx etcd;\
    mkdir -p /etc/nginx/ssl;\
    mkdir -p /etc/nginx/sites;\
    mkdir -p /run/nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY manager.sh /manager.sh
COPY run.sh /run.sh
EXPOSE 80 443
ENTRYPOINT ["/run.sh"]
