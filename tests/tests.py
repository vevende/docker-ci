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

    if process.returncode != 0:
        if not silent:
            assert False, f'Command exit with error: {stderr}'

    return Return(stdout.decode(), stderr.decode(), process.returncode)


class TestCase(unittest.TestCase):
    def test_python_binaries(self):
        run('which python3')
        run('which pip3')

        ret = run('python3 -V')
        assert ret.stdout.strip() == 'Python 3.6.3', ret

    def test_aws_tools_installed(self):
        run('which aws')
        run('which ecs-cli')

    def test_docker_installed(self):
        run('which docker')
        run('which docker-compose')

    def test_ansible_installed(self):
        run('which ansible')

    def test_common_tools(self):
        run('which git')
        run('which rsync')
        run('which bash')
        run('which tree')
        run('which tmux')

    def test_slugify(self):
        ret = run('slugify google.com')
        assert ret.stdout == 'google-com', ret

        ret = run('slugify google.com/path/path')
        assert ret.stdout == 'google-com-path-path', ret

        ret = run('slugify   word word word words ')
        assert ret.stdout == 'word-word-word-words', ret
