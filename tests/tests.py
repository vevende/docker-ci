import subprocess
import unittest
from collections import namedtuple

Return = namedtuple('Return', ['stdout', 'stderr', 'exitcode'])


def run(command, silent=False):
    args = command.split()
    ret = subprocess.run(args=args, stdout=subprocess.PIPE)

    if not silent:
        ret.check_returncode()

    stdout, stderr = None, None

    if ret.stdout:
        stdout = ret.stdout.decode()
    if ret.stderr:
        stderr = ret.stderr.decode()

    return Return(stdout, stderr, ret.returncode)


class TestCase(unittest.TestCase):
    def test_installed_packages(self):
        run('which git')
        run('which docker')
        run('which docker-compose')
        run('which rsync')
        run('which bash')
        run('which tree')
        run('which tmux')

    def test_python3(self):
        run('which pip3')
        run('which pip')

        run('which python')
        run('which python3')

        ret = run('python --version')
        assert ret.stdout.strip() == 'Python 3.6.0'

