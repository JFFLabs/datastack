FROM debian:bookworm
ARG PKG_NAME

RUN apt-get update
RUN apt-get install -y wget gnupg ca-certificates software-properties-common

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor --yes -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" | tee /etc/apt/sources.list.d/hashicorp.list

RUN wget -O- https://download.docker.com/linux/debian/gpg | gpg --dearmor --yes -o /usr/share/keyrings/docker.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update
RUN apt-get install -y iproute2 iputils-ping openssh-client git curl jq terraform docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin wait-for-it

COPY ./docker /app
COPY ./.env /app/.env

ENV PATH="/app:$PATH"

CMD ["sleep", "infinity"]
