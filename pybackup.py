#!/usr/bin/env python3

#
# Recursively removing old backup files in backup directories
#
# 2018-2021 Denis Pavlov
#

import os
import time

from configread import configread
from json import load


# set project name as current directory name
project = os.path.abspath(__file__).split('/')[-2]

# set config file name
conf_file = '/usr/local/pybackup/conf.d/pybackup.conf'

# read configuration parameters and save it to dictionary
backup_parameters = configread(conf_file, 'Backup', 'backup_custom_dirs_file',
                               'backup_main_dir', 'default_storage_period')

backup_main_dir = backup_parameters['backup_main_dir']
default_storage_period = int(backup_parameters['default_storage_period'])

# form dictionary of backup directories parameters
with open(backup_parameters['backup_custom_dirs_file'], "r") as backup_custom_dirs_file:
    backup_custom_dirs = load(backup_custom_dirs_file)

print('Directories with custom config:')
for directory, parameters in backup_custom_dirs.items():
    print(f'directory: {directory}, parameters: {parameters}')


def remove_old_files(entry, parent_storage_period):

    if entry.is_dir():
        if entry.path not in backup_custom_dirs:
            print(
                f'Directory {entry.path} will be scanned for old backup files')
            for entry in os.scandir(entry.path):
                remove_old_files(entry, parent_storage_period)
        else:
            is_delete = backup_custom_dirs[entry.path].get('delete', 'no')
            if is_delete == 'yes':
                storage_period = backup_custom_dirs[entry.path].get(
                    'storage_period', parent_storage_period)
                print(
                    f'Directory {entry.path} have custom config and '
                    f'will be scanned for backup files older than {storage_period} days')
                for entry in os.scandir(entry.path):
                    remove_old_files(entry, storage_period)
            else:
                print(f'Directory {entry.path} is protected from deleting')
    elif entry.is_file():
        creation_days_ago = int(
            (time.time() - os.stat(entry.path).st_mtime)/86400)
        if creation_days_ago > parent_storage_period:
            os.remove(entry.path)
            print(
                f'File {entry.path} was modified more than {parent_storage_period} days ago and deleted')


def main():

    # scan backup root directory
    for entry in os.scandir(backup_main_dir):
        remove_old_files(entry, default_storage_period)


if __name__ == "__main__":
    main()
