FROM nginx:alpine
MAINTAINER Prashant Mittal
ENV HUGO_VERSION="0.60.1"
ENV GITHUB_USERNAME="prashantmittal"
ENV DOCKER_IMAGE_NAME="hugo-app"

USER root

RUN apk add --update \
    wget \
    git \
    ca-certificates

RUN wget --quiet https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    tar -xf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    chmod +x hugo && \
    mv hugo /usr/local/bin/hugo && \
    rm -rf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

RUN git clone https://github.com/${GITHUB_USERNAME}/${DOCKER_IMAGE_NAME}.git

RUN hugo -s ${DOCKER_IMAGE_NAME} -d /usr/share/nginx/html/ --uglyURLs

CMD nginx -g "daemon off;"
