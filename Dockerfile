FROM docker:1.13

RUN apk add --no-cache make bash git rsync openssh-client py-pip tmux tree

CMD ["bash"]

