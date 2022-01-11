FROM ubuntu:18.04

ENV REPO_URL=${REPO_URL}
ENV REGISTRATION_TOKEN=${REGISTRATION_TOKEN}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl awscli gnupg docker.io

## Github Runner
RUN mkdir actions-runner && cd actions-runner \
    && curl -o actions-runner-linux-x64-2.277.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.277.1/actions-runner-linux-x64-2.277.1.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.277.1.tar.gz && ./bin/installdependencies.sh

COPY start.sh start.sh

ENTRYPOINT ./start.sh
