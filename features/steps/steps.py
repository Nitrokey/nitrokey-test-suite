import time

import pexpect
from behave import *

class Object(object):
    pass


glcon = Object()

@given("Run '{command}'")
def run_cmd(context, command: str):
    import sys
    context.child = pexpect.spawn(command)
    context.child.logfile = open('log.txt', 'ba')
    context.vars = {}  # TODO check should vars be cleared on each run
    context.optional = {}  # TODO check should optional be cleared on each run


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


def wait_for(context, s, timeout):
    print(f'Waiting for "{s}" for {timeout} seconds')
    return context.child.expect(s, timeout)


@when("({optional}) on '{result}' say '{action}'")
@when("on '{result}' say '{action}'")
def impl(context, action, result, optional=None):
    # TODO same for action?
    if result in context.vars:
        result = context.vars[result]

    if optional:
        context.optional[result] = action
        return

    for i in range(10):
        try:
            wait_for(context, result, timeout=1)
            context.child.sendline(action)
            time.sleep(1)
            return
        except:
            pass

        # check for the all registered optionals
        for rr, aa in context.optional.items():
            try:
                wait_for(context, rr, timeout=0.2)
                context.child.sendline(aa)
                time.sleep(1)
                # remove after one-time use
                del context.optional[result]  # FIXME allow recurrent checks
            except:
                pass

    context.child.expect(result, timeout=2)
    context.child.sendline(action)


@when("send '{action}'")
def impl(context, action):
    context.child.sendline(action)


@then("finish with success")
def imp(context):
    pass
