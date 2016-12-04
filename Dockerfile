FROM dr.forum.lo/ubuntu:python3-cron
MAINTAINER Denis O. Pavlov pavlovdo@gmail.com

RUN apt-get update && apt-get upgrade -y \
	&& rm -rf /var/lib/apt/lists/*

ADD *.py /usr/local/orbit/pybackup/

RUN echo "00 04 * * *   /usr/local/orbit/pyconfigvc/pyconfigvc.py > /usr/local/orbit/pyconfigvc/data/output" > /tmp/crontab && \
        crontab /tmp/crontab && rm /tmp/crontab
