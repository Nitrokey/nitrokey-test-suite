# nitrokey-test-suite
BDD Python 3 tests of GnuPG functionality (using CLI) in connection with OpenPGP v2.1+ compatible smartcard.
Project uses (Behave)[https://pythonhosted.org/behave/index.html] for test running and description and
(Pexpect)[http://pexpect.readthedocs.io/en/stable/] for in/out slave app control.
This gives the possibility of human-readable description of use cases, disconnected from the actual implementation.

## Installation
In terminal please run:
```
pip3 install -r requirements.txt --user
```
This will install required Python packages in user's space.

## Writing tests
Please consult with Behave's tutorial for fast and easy (introduction)[https://pythonhosted.org/behave/tutorial.html].
See (features/000_empty_check.feature)[features/000_empty_check.feature] for example test and
(steps/steps.py)[steps/steps.py] for steps implementation.

### Tagging tests
To tag a test precede the scenario with @name_of_the_tag. More details in Behave documentation.

## Running
Usually one only needs:
```
behave
```
This will run all feature tests from current directory.

Popular switches are:
- `--stop` switch will stop the tests after first failure
- `--tags` allows to select/deselect tests with given tags, e.g.:
```
behave --tags=-openpgp_v2.1
```
will deselect all tests with tag `openpgp_v2.1`.

For detailed description please consult Behave (documentation)[https://pythonhosted.org/behave/behave.html#command-line-arguments].
