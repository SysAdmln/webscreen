FROM python:3.7.15-bullseye
MAINTAINER sys@dmin.pro

WORKDIR /tmp

RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    curl -LO https://chromedriver.storage.googleapis.com/107.0.5304.62/chromedriver_linux64.zip && \
    apt update && \
    apt install -y unzip google-chrome-stable && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    /usr/local/bin/python -m pip install --upgrade pip

ENV LANG=ru_RU.UTF-8
ENV LANGUAGE="ru_RU:en_US"

ADD requirements.txt /tmp/
RUN pip install -r requirements.txt

RUN mkdir -p /tmp/screenshot
WORKDIR /tmp/screenshot
ADD screenshot.py /tmp/

ENTRYPOINT ["python", "/tmp/screenshot.py"]
CMD ["--help"]
