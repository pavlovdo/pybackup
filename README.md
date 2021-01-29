Description
===========
Recursively deleting old backup files in backup directory

Be careful using this software - its deleting data (!)


Requirements
============
python >= 3.6


Installation
============
1) Clone pybackup repo to directory /usr/local/orbit on your backup host:
```
sudo mkdir -p /usr/local/orbit
cd /usr/local/orbit
sudo git clone https://github.com/pavlovdo/pybackup
```

2) A) Check execute permissions for scripts:
```
ls -l *.py *.sh
```
B) If not:
```
sudo chmod +x *.py *.sh
```

3) Change example configuration file pybackup.conf: backup main directory, backup long storing directory, backup exclude delete directories;

4) Further you have options: run scripts from host or run scripts from docker container.

If you want to run scripts from host:

C) Plan deleting old backups and create cron jobs:
```
echo "00 04 * * * /usr/local/orbit/pybackup/pybackup.py > /usr/local/orbit/pybackup/data/output" > /tmp/crontab && \
crontab /tmp/crontab && rm /tmp/crontab
```

If you want to run scripts from docker container:

A) Run build.sh:
```
cd /usr/local/orbit/pybackup
./build.sh
```

B) Run dockerrun.sh;
```
./dockerrun.sh
```


Tested
======
Cent OS 7.8, 8.2


Related Links
=============
https://www.python.org/dev/peps/pep-0471/

https://docs.python.org/3/library/os.html#os.scandir
