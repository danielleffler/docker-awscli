FROM docker:stable-dind as ecr-login

RUN set -exo pipefail \
    && apk add --no-cache \
        gettext \
        git \
        go \
        make \
        musl-dev \
    && go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login


FROM docker
RUN apk add --update py-pip
RUN pip install awscli
COPY --from=ecr-login /root/go/bin/docker-credential-ecr-login /usr/local/bin/docker-credential-ecr-login
COPY ./config.json /root/.docker/config.json