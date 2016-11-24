#!/usr/bin/env python3

from configread import configread
# from datetime import datetime
import os
import time

# Read the configuration file with parameters,
# location of configuration file - as in production system
backup_parameters = configread('/usr/local/orbit/pybackup/pybackup.conf',
                               'Backup', 'backup_main_dir')

for entry1 in os.scandir(backup_parameters['backup_main_dir']):
    if entry1.is_dir():
        for entry2 in os.scandir(entry1):
            if entry2.is_file():
                print(entry1.name, entry2.name,
                      int((time.time() - os.stat(entry2.path).st_mtime)/3600))
