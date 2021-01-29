#!/usr/bin/env python3

#
# Recursively removing old backup files in backup directory
#
# 2018-2021 Denis Pavlov
#

import os
import time

from configread import configread


# set config file name
conf_file = '/usr/local/orbit/pybackup/conf.d/pybackup.conf'

# read configuration parameters and save it to dictionary
backup_parameters = configread(conf_file, 'Backup', 'backup_main_dir',
                               'backup_dirs_exclude',
                               'backup_dirs_lts',
                               'default_max_days')

# get root backup directory
backup_main_dir = backup_parameters['backup_main_dir']

# get list of directories where exist files for long time storing
backup_dirs_lts = backup_parameters['backup_dirs_lts'].split(',')

# initialize default max days for backup storing
max_days = backup_parameters['default_max_days']

# get list of exclude directories with undeletable backups
backup_dirs_exclude = backup_parameters['backup_dirs_exclude']
backup_dirs_exclude = eval(backup_dirs_exclude)


def removeoldfiles(entry):
    """ remove old backup files """

    creation_days_ago = int((time.time() - os.stat(entry.path).st_mtime)/86400)
    max_days = int(backup_parameters['default_max_days'])
    if os.path.dirname(entry.path) in backup_dirs_lts:
        max_days = 184
    if creation_days_ago > max_days:
        os.remove(entry.path)
        print('File', entry.path, 'was modified more than ' +
              str(max_days) + ' days ago and will be deleted\n')


def main():

    # scan backup root directory
    for entry1 in os.scandir(backup_main_dir):
        if entry1.is_dir() and entry1 not in backup_dirs_exclude:
            # scan subdirectories for searching and deleting old files
            for entry2 in os.scandir(entry1.path):
                if entry2.is_file():
                    removeoldfiles(entry2)
                elif entry2.is_dir() and entry2 not in backup_dirs_exclude:
                    for entry3 in os.scandir(entry2.path):
                        if entry3.is_file():
                            removeoldfiles(entry3)
                        elif entry3.is_dir() and entry3 not in backup_dirs_exclude:
                            for entry4 in os.scandir(entry3.path):
                                if entry4.is_file():
                                    removeoldfiles(entry4)


if __name__ == "__main__":
    main()
