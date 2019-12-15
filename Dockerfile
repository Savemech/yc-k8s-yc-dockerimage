FROM alpine:latest
RUN \
apk -U add --no-cache --virtual .build-deps git curl bash && \
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl && \
curl -LO https://storage.yandexcloud.net/yandexcloud-yc/release/$(curl -s https://storage.yandexcloud.net/yandexcloud-yc/release/stable)/linux/amd64/yc && \
mv yc /usr/local/bin/yc && chmod +x /usr/local/bin/yc && \
apk del .build-deps && \
apk add bash jq ca-certificates curl && \
kubectl version --client && \
yc version && \
cat /etc/issue


ENTRYPOINT []
CMD []
