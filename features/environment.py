import signal


def before_all(context):
    pass

def after_scenario(context, scenario):
    if getattr(context, 'child', None) is not None:
        context.child.kill(signal.SIGINT)
        context.child.wait()