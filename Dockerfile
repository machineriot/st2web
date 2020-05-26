FROM node:10.20.1-buster

ARG DEBIAN_FRONTEND=noninteractive

ARG ST2_VERSION

# Generate UTF-8 locale
RUN apt-get -qq update \
  && apt-get install -y \
    curl \
    locales \
    gpg \
  && rm -rf /var/lib/apt/lists/* \
  && locale-gen en_US.UTF-8 \
  # && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN mkdir -p /app

RUN npm install -g gulp-cli lerna
COPY ./* /app/

WORKDIR /app

RUN lerna bootstrap

#ENTRYPOINT ["gulp"]

#EXPOSE 80
EXPOSE 3000
