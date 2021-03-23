FROM centos:latest
LABEL maintainer="Denis O. Pavlov pavlovdo@gmail.com"

ARG project

RUN   dnf update -y && \
      dnf install -y \
      cronie \
      python36 && \
      rm -rf /var/cache/dnf

COPY *.py requirements.txt /usr/local/orbit/${project}/
WORKDIR /usr/local/orbit/${project}

ENV TZ=Europe/Moscow
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

RUN echo "00 04 * * *   /usr/local/orbit/pybackup/pybackup.py 1> /proc/1/fd/1 2> /proc/1/fd/2" > /tmp/crontab && \
      crontab /tmp/crontab && rm /tmp/crontab

CMD ["crond","-n"]
