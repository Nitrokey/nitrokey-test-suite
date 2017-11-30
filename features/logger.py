import logging

import sys

my_logger = None

def get_logger():
    global my_logger
    if my_logger:
        return my_logger
    logger = logging.getLogger('nitrokey-test-suite')
    logger.setLevel(logging.DEBUG)
    ch = logging.StreamHandler(stream=sys.stdout)
    ch.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(relativeCreated)d %(levelname)s %(funcName)s %(message)s File "%(pathname)s", line %(lineno)d')
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    return logger

my_logger = get_logger()

my_logger.debug('its alive')