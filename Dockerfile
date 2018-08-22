FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
        curl \
        git \
        groff \
        less \
        jq \
        python3

RUN curl -sL https://sentry.io/get-cli/ | bash
RUN curl -sL https://bootstrap.pypa.io/get-pip.py | python3
RUN pip3 install -U \
        awscli \
        ecs-deploy

RUN curl \
    -o /usr/bin/ecs-deploy \
    https://raw.githubusercontent.com/silinternational/ecs-deploy/master/ecs-deploy 
RUN chmod +x /usr/bin/ecs-deploy

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8
