import pexpect
from behave import *

from nose.tools import *
from binascii import hexlify

import binascii

from pexpect import spawn


class Object(object):
    pass


glcon = Object()


#
# def text_to_bin(v):
#     vr = v
#     try:
#         import binascii
#         vr = vr.replace('\\x', '')
#         vr = vr.replace('"', '')
#         vr = binascii.unhexlify(vr)
#     except:
#         vr = v
#         my_logger.debug('not binasci')
#
#     try:
#         vr = vr.encode()
#     except:
#         my_logger.debug('not encoded in text_to_bin')
#         pass
#
#     return vr

# @given('cmd_verify with {who_str} and "{pass_str}"')
# def cmd_verify(context,who_str,pass_str):
#     if not getattr(glcon, 'oldpass', None):
#         glcon.oldpass = {}
#
#     who = int(who_str)
#     pass_str = pass_str[:32].encode()  # OpenPGP v2.1 uses 32 bytes for storage, v3.3 32 UTF8 chars (here made for v3.3/utf-8)
#     oldpass_get = glcon.oldpass.get(who_str, 'not-set')
#     my_logger.debug('Last set password: "{}" , trying: "{}", same: "{}"'.format(oldpass_get, pass_str.decode(), oldpass_get == pass_str.decode()))
#     context.result = context.token.cmd_verify(who, pass_str)


# class logfile(Object):
#     def write(self):
#         return sys.stderr.write(w)

@given("Run '{command}'")
def run_cmd(context, command: str):
    import sys
    context.child = pexpect.spawn(command)
    context.child.logfile = open('log.txt', 'ba')
    context.vars = {}  # TODO check should vars be cleared on each run


@given("set '{var}' to '{content}'")
def set(context, var, content):
    # if not getattr(context, 'vars', None):
    #     context.vars = {}
    context.vars[var] = content


@when("{action} if will see '{what}' in {seconds} seconds")
@when("{action} if will see '{what}'")
@when("wait for '{what}'")
@when("wait for '{what}' for {seconds} seconds")
def impl(context, what, seconds=30, action=None):
    seconds = int(seconds)
    if what in context.vars:
        what = context.vars[what]
    if action is None:
        context.child.expect(what, timeout=seconds)
    else:
        if 'fail' in action:
            what_shown = True
            try:
                context.child.expect(what, timeout=seconds)
                what_shown = True
            except:
                what_shown = False
            if what_shown:
                raise Exception('Failing due to test condition')


@when("'{action}' results in '{result}'")
@when("'{action}' -> '{result}'")
def impl(context, action, result):
    # TODO same for action?
    if result in context.vars:
        result = context.vars[result]
    context.child.sendline(action)
    context.child.expect(result)


@when("({optional}) on '{result}' say '{action}'")
@when("on '{result}' say '{action}'")
def impl(context, action, result, optional=None):
    # TODO same for action?
    if result in context.vars:
        result = context.vars[result]
    if optional:
        try:
            context.child.expect(result, timeout=3)
            context.child.sendline(action)
        except:
            pass
    else:
        context.child.expect(result)
        context.child.sendline(action)


@when("send '{action}'")
def impl(context, action):
    context.child.sendline(action)


@then("finish with success")
def imp(context):
    pass
