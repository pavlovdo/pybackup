#!/usr/bin/env python3


def config_file_default():

    import os

    conf_file_default = ('/etc/orbit/'
                         + os.path.basename(__file__).split('.')[0]
                         + '/'
                         + os.path.basename(__file__).split('.')[0] + '.conf')

    return conf_file_default


def configread(config_file=config_file_default, section, *parameters):

    import configparser

    # Read the Orbit configuration file
    config = configparser.RawConfigParser()
    config.read(config_file)
    params = dict()

    for parameter in parameters:
        try:
            params[parameter] = config.get(section, parameter)
        except configparser.NoOptionError as err:
            print (err, '. Please set ' + parameter + ' value in the ' +
                   'configuration file ' + config_file)

    return params
