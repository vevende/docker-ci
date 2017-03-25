FROM docker:1.13

# Common tools
RUN set -ex \
    && apk add --no-cache \
       make openssh-client \
       rsync git tmux tree

# Language and framework related
RUN set -ex \
    && apk add --no-cache  python3 bash \
    && ln -sf /usr/bin/python3.6    /usr/bin/python \
    && ln -sf /usr/bin/pydoc3.6     /usr/bin/pydoc \
    && ln -sf /usr/bin/pip3.6       /usr/bin/pip \
    && ln -sf /usr/bin/easy_install-3.6 /usr/bin/easy_install

CMD ["bash"]

