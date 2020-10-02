#!/usr/bin/env python3

from configread import configread
import os
import time

# read parameters from config file
conf_file = ('/etc/orbit/' + os.path.basename(__file__).split('.')[0] + '/'
             + os.path.basename(__file__).split('.')[0] + '.conf')

# read configuration parameters and save it to dictionary
backup_parameters = configread(conf_file, 'Backup', 'backup_main_dir',
                              'backup_dirs_lts', 'default_max_days')

backup_main_dir = backup_parameters['backup_main_dir']

# get list of directories where exist files for long time storing
backup_dirs_lts = backup_parameters['backup_dirs_lts'].split(',')

max_days = backup_parameters['default_max_days']


def removeoldfiles(entry):

    creation_days_ago = int((time.time() - os.stat(entry.path).st_mtime)/86400)
    max_days = int(backup_parameters['default_max_days'])
    if os.path.dirname(entry.path) in backup_dirs_lts:
        max_days = 184
    if creation_days_ago > max_days:
        os.remove(entry.path)
        print('File', entry.path, 'was modified more than ' + str(max_days) + ' days ago and will be deleted\n')


# scan backup root directory
for entry1 in os.scandir(backup_main_dir):
    if entry1.is_dir():
        # scan subdirectories for searching and deleting old files
        for entry2 in os.scandir(entry1.path):
            if entry2.is_file():
                removeoldfiles(entry2)
            elif entry2.is_dir():
                for entry3 in os.scandir(entry2.path):
                    if entry3.is_file():
                        removeoldfiles(entry3)
                    elif entry3.is_dir():
                        for entry4 in os.scandir(entry3.path):
                            if entry4.is_file():
                                removeoldfiles(entry4)
