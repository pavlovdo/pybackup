FROM dr.forum.lo/ubuntu:python3-cron
MAINTAINER Denis O. Pavlov pavlovdo@gmail.com

RUN apt-get update &&\
      apt-get upgrade -y

ADD configread.py /usr/local/orbit/pybackup/configread.py
ADD pybackup.conf /usr/local/orbit/pybackup/pybackup.conf
ADD pybackup.py /usr/local/orbit/pybackup/pybackup.py

RUN echo "00 05 * * *	/usr/local/orbit/pybackup/pybackup.py > /usr/local/orbit/pybackup/data/output" > /tmp/crontab
RUN crontab /tmp/crontab
RUN rm /tmp/crontab
CMD /usr/sbin/cron -f
