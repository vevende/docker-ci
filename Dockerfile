FROM docker:1.13

# Use edge packages
RUN set -ex \
    && sed -i -e 's/v3\.\d/edge/g' /etc/apk/repositories \
    && apk add --update --no-cache \
       make openssh-client bash python \
       rsync git tmux tree ansible \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir docker-compose

COPY bashrc /root/.bashrc

CMD ["/bin/bash"]
