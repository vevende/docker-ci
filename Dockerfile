FROM docker:1.13

ENV LANG="C.UTF-8" \
    LC_ALL="C" \
    LC_COLLATE="C"

RUN set -ex \
    && apk add --update --no-cache \
       build-base openssh-client ca-certificates \
       bash rsync git tmux tree curl wget \
       python2 python2-dev py-pip libffi-dev openssl-dev

RUN set -ex \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir docker-compose ansible awscli

RUN set -ex \
    && echo -e "Host *"                          >  /etc/ssh/ssh_config \
    && echo -e "\tStrictHostKeyChecking no"      >> /etc/ssh/ssh_config \
    && echo -e "\tServerAliveInterval 10"        >> /etc/ssh/ssh_config \
    && echo -e "\tServerAliveCountMax 2"         >> /etc/ssh/ssh_config \
    && echo -e "\tControlMaster auto"            >> /etc/ssh/ssh_config \
    && echo -e "\tControlPath /tmp/ssh-%h-%p-%r" >> /etc/ssh/ssh_config \
    && echo -e "\tControlPersist 30m"            >> /etc/ssh/ssh_config \
    && mkdir -p /etc/ansible \
    && echo "[ssh_connection]"                   > /etc/ansible/ansible.cfg \
    && echo "ssh_args = -o ForwardAgent=yes -o ControlMaster=auto -o StrictHostKeyChecking=no -o ControlPersist=60s" >> /etc/ansible/ansible.cfg \
    && echo "pipelining = True"                  >> /etc/ansible/ansible.cfg 

COPY bin/*  /usr/local/bin/
COPY bashrc /root/.bashrc

CMD ["bash"]
