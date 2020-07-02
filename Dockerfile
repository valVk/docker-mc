FROM ubuntu:20.04

WORKDIR /opt/app

RUN apt-get update \
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs

RUN npm i -g express-generator

RUN express

RUN npm i

COPY ./entrypoint.sh /bin/entrypoint

ENTRYPOINT [ "bash", "/bin/entrypoint" ]