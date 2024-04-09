FROM ubuntu:latest

ARG PB_VERSION=0.22.8

RUN apt-get update && apt-get install --no-install-recommends -y \
    unzip \
    ca-certificates \
    wget && \
    rm -rf /var/lib/apt/lists/*

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

EXPOSE 8080

# start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
