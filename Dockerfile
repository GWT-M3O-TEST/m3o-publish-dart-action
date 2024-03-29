FROM golang:1.17.8-bullseye

WORKDIR /factory

# set up tools
RUN apt-get update && apt-get upgrade -y

# install dart
RUN apt-get install apt-transport-https
RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/dart.gpg
RUN echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | tee /etc/apt/sources.list.d/dart_stable.list
RUN apt-get update
RUN apt-get install dart
RUN export PATH="$PATH:/usr/lib/dart/bin"

COPY entrypoint.sh /entrypoint.sh

# change permission to execute entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]