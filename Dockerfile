FROM alpine:latest

LABEL maintainer="Anton Strukov"
LABEL github="https://github.com/Savemech/yc-k8s-yc-dockerimage"
LABEL purpose="Run tasks from CI/CD/k8s/other systems, without humans"
#https://github.com/GoogleCloudPlatform/cloud-sdk-docker/blob/master/alpine/Dockerfile

ARG CLOUD_SDK_VERSION=300.0.0

ENV PATH /google-cloud-sdk/bin:$PATH
ENV PATH /root/google-cloud-sdk/bin:$PATH


RUN \
apk -U add --no-cache --virtual .build-deps python3 git curl bash && \
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl && \
curl -LO https://storage.yandexcloud.net/yandexcloud-yc/release/$(curl -s https://storage.yandexcloud.net/yandexcloud-yc/release/stable)/linux/amd64/yc && \
mv yc /usr/local/bin/yc && chmod +x /usr/local/bin/yc && \
curl -LO https://get.helm.sh/helm-$(curl -Ls https://github.com/helm/helm/releases | grep 'href="/helm/helm/releases/tag/v3.[0-9]*.[0-9]*\"' | grep -v no-underline | head -n 1 | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | awk 'a !~ $0{print}; {a=$0}')-linux-amd64.tar.gz && \
tar xfvz helm-*.tar.gz && \
mv linux-amd64/helm /usr/local/bin/helm && \
rm -rf helm-* && \
chmod +x /usr/local/bin/helm && \
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
#curl https://sdk.cloud.google.com | bash > /dev/null && \
# echo "export PATH=$PATH:/root/google-cloud-sdk/bin" | tee -a ~/.bashrc && \
gcloud config set core/disable_usage_reporting true && \
gcloud config set component_manager/disable_update_check true && \
apk del .build-deps && \
apk add bash jq python3 ca-certificates curl && \
kubectl version --client && \
yc version && \
helm version -c && \
cat /etc/issue && \
gcloud version


ENTRYPOINT []
CMD []
