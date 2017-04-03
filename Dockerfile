FROM docker:1.13

ENV LANG="C.UTF-8" \
    LC_ALL="C" \
    LC_COLLATE="C"

# Use edge packages
RUN set -ex \
    && apk add --update --no-cache \
       build-base openssh-client ca-certificates curl wget \
       bash python py-pip rsync git tmux tree ansible \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir docker-compose

COPY bashrc /root/.bashrc

CMD ["bash"]
