FROM ubuntu:latest
MAINTAINER Denis O. Pavlov pavlovdo@gmail.com

RUN apt-get update &&\
    	apt-get install cron -y &&\
	apt-get install curl -y &&\
	apt-get install python3 -y

COPY *.py /usr/local/orbit/pybackup/

RUN echo "00 04 * * *   /usr/local/orbit/pybackup/pybackup.py > /usr/local/orbit/pybackup/data/output" > /tmp/crontab && \
        crontab /tmp/crontab && rm /tmp/crontab

CMD ["/usr/sbin/cron","-f"]
