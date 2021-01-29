FROM centos:latest
MAINTAINER Denis O. Pavlov pavlovdo@gmail.com

ARG project

RUN   dnf update -y && \
      dnf install -y \
      cronie \
      python36 && \
      rm -rf /var/cache/dnf

ENV TZ=Europe/Moscow
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

COPY *.py requirements.txt /etc/zabbix/externalscripts/${project}/
WORKDIR /usr/local/orbit/${project}

RUN echo "00 04 * * *   /usr/local/orbit/pybackup/pybackup.py > /usr/local/orbit/pybackup/data/output" > /tmp/crontab && \
        crontab /tmp/crontab && rm /tmp/crontab

CMD ["crond","-n"]
