FROM node:5-wheezy

MAINTAINER Nicola Molinari <emmenko@gmail.com>

RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN curl -L https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN apt-get update && \
    apt-get install -y google-chrome-stable xvfb && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/

RUN npm install -g npm@3.3.12

ADD xvfb.sh /etc/init.d/xvfb
ADD entrypoint.sh /entrypoint.sh

ENV DISPLAY :99.0
ENV CHROME_BIN /usr/bin/google-chrome

RUN mkdir -p /app
WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
