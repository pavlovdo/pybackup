#!/usr/bin/env python3

from configread import configread
# from datetime import datetime
import os
import time

# Read the default configuration file with parameters,
# location of configuration file - as in production system
backup_parameters = configread('Backup', 'backup_main_dir')

for entry1 in os.scandir(backup_parameters['backup_main_dir']):
    if entry1.is_dir():
        for entry2 in os.scandir(entry1.path):
            if entry2.is_file():
                creation_hours_ago = int((time.time()
                                         - os.stat(entry2.path).st_ctime)/3600)
                print('File', entry2.path, 'was created', creation_hours_ago,
                      'hours ago\n')
                if creation_hours_ago > 744:
                    os.remove(entry2.path)
                    print('File', entry2.path, 'was deleted\n')
