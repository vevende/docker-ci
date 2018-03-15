import subprocess
import unittest
from collections import namedtuple

Return = namedtuple('Return', ['stdout', 'stderr', 'exitcode'])


def run(command, silent=False):
    args = command.split()
    process = subprocess.Popen(args=args,
                           stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)
    process.wait()
    stdout, stderr = process.communicate()

    if process.returncode == 0:
        print(stdout)
        print(stderr)
        
        if not silent:
            assert False, f'Command exit with error: {stderr}'

    return Return(stdout, stderr, process.returncode)


class TestCase(unittest.TestCase):
    def test_installed_packages(self):
        run('which git')
        run('which docker')
        run('which docker-compose')
        run('which ansible')
        run('which aws')
        run('which rsync')
        run('which bash')
        run('which tree')
        run('which tmux')
        run('which pip3')
        run('which python3')

        ret = run('python3 -V')
        assert ret.stderr.strip() == 'Python 3.6.3', ret.stderr

    def test_slugify(self):
        ret = run('slugify google.com')
        assert ret.stdout == 'google-com'

        ret = run('slugify google.com/path/path')
        assert ret.stdout == 'google-com-path-path'

        ret = run('slugify   word word word words ')
        assert ret.stdout == 'word-word-word-words'
