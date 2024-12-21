FROM debian:bookworm

COPY ./ /stack
RUN apt-get update && apt-get install -y curl wget git gnupg software-properties-common iproute2 ca-certificates

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN curl -fsSL https://get.docker.com -o get-docker.sh | bash
RUN apt-get update
RUN apt-get install -y terraform

ENV PATH="/stack/env:$PATH"

CMD ["sleep", "infinity"]
