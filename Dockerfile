# Dockerfile for testing repo.

FROM ubuntu


SHELL [ "/bin/bash", "-c" ]


ENV DEBIAN_FRONTEND noninteractive


RUN mkdir -p $HOME/.ssh && \
    ln -s /run/secrets/id_rsa $HOME/.ssh/id_rsa


# Install gosu for a better su+exec command
RUN set -eux && \
    apt-get update && \
    apt-get install -y gosu && \
    rm -rf /var/lib/apt/lists/* && \
    gosu nobody true
    

WORKDIR /home/${USER}


RUN apt-get update && \
    apt-get install -y \
        sudo \
        vim \
        salt-minion


COPY bin/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

