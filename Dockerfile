FROM alpine:latest
RUN \
apk -U add --no-cache --virtual .build-deps python3 git curl bash && \
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl && \
curl -LO https://storage.yandexcloud.net/yandexcloud-yc/release/$(curl -s https://storage.yandexcloud.net/yandexcloud-yc/release/stable)/linux/amd64/yc && \
mv yc /usr/local/bin/yc && chmod +x /usr/local/bin/yc && \
curl -LO https://get.helm.sh/helm-$(curl -Ls https://github.com/helm/helm/releases | grep 'href="/helm/helm/releases/tag/v3.[0-9]*.[0-9]*\"' | grep -v no-underline | head -n 1 | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | awk 'a !~ $0{print}; {a=$0}')-linux-amd64.tar.gz && \
tar xfvz helm-*.tar.gz && \
mv linux-amd64/helm /usr/local/bin/helm && \
chmod +x /usr/local/bin/helm && \
curl https://sdk.cloud.google.com | bash > /dev/null && \
echo "export PATH=$PATH:/root/google-cloud-sdk/bin" | tee -a ~/.bashrc && \
apk del .build-deps && \
apk add bash jq python3 ca-certificates curl && \
kubectl version --client && \
yc version && \
helm version -c && \
cat /etc/issue && \
/root/google-cloud-sdk/bin/gcloud version


ENTRYPOINT []
CMD []
