FROM gliderlabs/alpine
RUN apk-install -t builddeps go git;\
    mkdir /build;\
    GOPATH=/build go get github.com/skynetservices/skydns;\
    cd /build/src/github.com/skynetservices/skydns;\
    GOPATH=/build go build -v;\
    mv skydns /skydns;\
    cd / && rm -rf /build;\
    apk del builddeps
EXPOSE 53/udp
ENV SKYDNS_ADDR=0.0.0.0:53 SKYDNS_NAMESERVERS=8.8.8.8:53,8.8.4.4:53
ENTRYPOINT ["/skydns"]
