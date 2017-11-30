

def before_all(context):
    pass

def after_scenario(context, scenario):
    if getattr(context, 'child', None) is not None:
        context.child.kill()
        context.child.wait()