#!/usr/bin/env python3


def configread(conf_file, section, *parameters):

    import configparser

    # Read the Orbit configuration file
    config = configparser.RawConfigParser()
    config.read(conf_file)
    params = dict()

    for parameter in parameters:
        try:
            params[parameter] = config.get(section, parameter)
        except configparser.NoOptionError as err:
            print (err, '. Please set ' + parameter + ' value in the ' +
                   'configuration file ' + conf_file)

    return params
