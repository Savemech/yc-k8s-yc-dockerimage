FROM alpine:latest
RUN \
apk -U add --no-cache --virtual .build-deps git curl bash && \
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl && \
curl -LO https://storage.yandexcloud.net/yandexcloud-yc/release/$(curl -s https://storage.yandexcloud.net/yandexcloud-yc/release/stable)/linux/amd64/yc && \
mv yc /usr/local/bin/yc && chmod +x /usr/local/bin/yc && \
curl -LO https://get.helm.sh/helm-$(curl -sL https://github.com/helm/helm/releases | sed -n '/Latest release<\/a>/,$p' | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1)-linux-amd64.tar.gz && \
tar xfvz helm-*.tar.gz && \
mv linux-amd64/helm /usr/local/bin/helm && \
chmod +x /usr/local/bin/helm && \
apk del .build-deps && \
apk add bash jq ca-certificates curl && \
kubectl version --client && \
yc version && \
helm version && \
cat /etc/issue


ENTRYPOINT []
CMD []
