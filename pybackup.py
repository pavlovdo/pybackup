#!/usr/bin/env python3

from configread import configread
# from datetime import datetime
import os

# Read the configuration file with parameters,
# location of configuration file - as in production system
backup_parameters = configread('./pybackup.conf',
                               'Backup', 'backup_main_dir')

for entry in os.scandir(backup_parameters['backup_main_dir']):
    if not entry.name.startswith('.') and entry.is_dir():
        print(entry.name)
