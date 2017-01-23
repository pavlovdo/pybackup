FROM ubuntu:latest
MAINTAINER Denis O. Pavlov pavlovdo@gmail.com

RUN apt-get update && apt-get install -y \
        cron \
        curl \
        python3

ENV TZ=Europe/Moscow
ENV DEBIAN_FRONTEND=noninteractive
#RUN echo $TZ | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

COPY *.py /usr/local/orbit/pybackup/

RUN echo "00 04 * * *   /usr/local/orbit/pybackup/pybackup.py > /usr/local/orbit/pybackup/data/output" > /tmp/crontab && \
        crontab /tmp/crontab && rm /tmp/crontab

CMD ["/usr/sbin/cron","-f"]
