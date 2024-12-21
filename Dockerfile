FROM debian:bookworm

COPY ./docker /env
RUN apt-get update && apt-get install -y wget git gnupg software-properties-common iproute2 ca-certificates

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN wget -O- https://get.docker.com | bash
RUN apt-get update
RUN apt-get install -y terraform

ENV PATH="/env:$PATH"

CMD ["sleep", "infinity"]
