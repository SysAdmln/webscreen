FROM python:3.7.15-bullseye
MAINTAINER sys@dmin.pro

WORKDIR /tmp

ADD requirements.txt /tmp/
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    curl -LO https://chromedriver.storage.googleapis.com/110.0.5481.77/chromedriver_linux64.zip && \
    mkdir -p /tmp/screenshot && \
    apt update -qq && \
    apt install -y --no-install-recommends \
    unzip google-chrome-stable \
    fonts-freefont-ttf fonts-freefont-ttf && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    pip3 install -r requirements.txt && \
    apt autoremove -y && \
    apt clean && \
    apt autoclean -y && \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/cache/debconf/*-old \
        /var/lib/dpkg/*-old/ \
        /usr/share/man/* \
        /usr/share/doc/**/*.gz \
        /usr/share/locale/

ENV LANG=ru_RU.UTF-8
ENV LANGUAGE="ru_RU:en_US"

WORKDIR /tmp/screenshot
ADD screenshot.py /tmp/

#ENTRYPOINT ["python", "/tmp/screenshot.py"]
#CMD ["--help"]
