FROM ubuntu:latest as download

# Update and install required packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y curl wget unzip

RUN curl -s https://get-latest.deno.dev/pocketbase/pocketbase?no-v=true >> tag.txt

RUN wget https://github.com/pocketbase/pocketbase/releases/download/v$(cat tag.txt)/pocketbase_$(cat tag.txt)_linux_amd64.zip \
    && unzip pocketbase_$(cat tag.txt)_linux_amd64.zip \
    && chmod +x /pocketbase

FROM ubuntu:latest

# Update and install required packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y git build-essential ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=download /pocketbase /usr/local/bin/pocketbase

EXPOSE 8090

ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/root/pocketbase"]
