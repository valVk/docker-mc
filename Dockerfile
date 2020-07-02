FROM alpine:3 as builder

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache --update openssh-keygen openssl \
    && ssh-keygen -t rsa -b 4096 -N "" -f /root/.ssh/id_rsa \
    && ssh-keygen -p -m PEM -f /root/.ssh/id_rsa \ 
    && openssl rsa -in /root/.ssh/id_rsa -pubout -outform PEM -out /root/.ssh/id_rsa.jwt


FROM ubuntu:20.04

WORKDIR /opt/app

RUN apt-get update \
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs

COPY ./entrypoint.sh /bin/entrypoint

COPY --from=builder /root/.ssh/ /root/.ssh/

RUN mkdir /opt/app2

ADD https://github.com/ValeriyDevPro/docker-mc/archive/p11.tar.gz /opt/app2

RUN mkdir /opt/app3

ADD ./p11.tar.gz /opt/app3/

ENTRYPOINT [ "bash", "/bin/entrypoint" ]