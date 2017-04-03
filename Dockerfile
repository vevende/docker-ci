FROM docker:1.13

ENV PATH /usr/local/bin:$PATH
ENV LANG C.UTF-8

# Use edge packages
RUN set -ex \
    && apk add --update --no-cache \
       make openssh-client ca-certificates \
       bash python2 rsync git tmux tree ansible \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir docker-compose

COPY bashrc /root/.bashrc
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/bin/bash"]
