FROM docker:1.13

ENV LANG="C.UTF-8" \
    LC_ALL="C" \
    LC_COLLATE="C"

# Use edge packages
RUN set -ex \
    && apk add --update --no-cache \
       build-base openssh-client ca-certificates \
       bash rsync git tmux tree curl wget \
       python python-dev py-pip libffi-dev \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir docker-compose ansible awscli
    && mkdir -p ~/.ssh \
    && echo -e "Host *"                          >  ~/.ssh/config \
    && echo -e "\tStrictHostKeyChecking no"      >> ~/.ssh/config \
    && echo -e "\tControlMaster auto"            >> ~/.ssh/config \
    && echo -e "\tControlPath /tmp/ssh-%h-%p-%r" >> ~/.ssh/config \
    && echo -e "\tControlPersist 30m"            >> ~/.ssh/config

COPY bashrc /root/.bashrc

CMD ["bash"]
