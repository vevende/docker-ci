FROM docker:1.13

# Common tools
RUN apk add --no-cache \
    make bash openssh-client \ 
    rsync git tmux tree

# Language and framework related
RUN apk add --no-cache python3

CMD ["bash"]

