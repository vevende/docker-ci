FROM docker:1.13

# Use edge packages
RUN set -ex \
    && sed -i -e 's/v3\.5/edge/g' /etc/apk/repositories

# Common tools
RUN set -ex \
    && apk add --no-cache \
       make openssh-client bash \
       rsync git tmux tree

# Language and framework related
RUN set -ex \
    && apk add --no-cache python3 \
    && curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" \
       -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && ln -s /usr/bin/python3.6    /usr/bin/python \
    && ln -s /usr/bin/pydoc3.6     /usr/bin/pydoc \
    && ln -s /usr/bin/pip3.6       /usr/bin/pip \
    && ln -s /usr/bin/easy_install-3.6 /usr/bin/easy_install \
    && pip install --no-cache-dir --upgrade pip

COPY bashrc /root/.bashrc

CMD ["bash"]
