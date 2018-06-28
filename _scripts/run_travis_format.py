#!/usr/bin/env python
# -*- encoding: utf-8
"""
Wrapper script for doing auto-formatting in Travis.

In particular, this script will autoformat Terraform, then commit
and push the results.
"""

from __future__ import print_function

import os
import subprocess

from config import TRAVIS_KEY, TRAVIS_IV
from hypothesistooling import changed_files, git, make


if __name__ == '__main__':
    make('format')

    # https://graysonkoonce.com/getting-the-current-branch-name-during-a-pull-request-in-travis-ci/
    if os.environ['TRAVIS_PULL_REQUEST'] == 'false':
        branch = os.environ['TRAVIS_BRANCH']
    else:
        branch = os.environ['TRAVIS_PULL_REQUEST_BRANCH']

    if changed_files():
        print(
            '*** There were changes from formatting, creating a commit',
            flush=True)

        git('config', 'user.name', 'Travis CI on behalf of Wellcome')
        git('config', 'user.email', 'wellcomedigitalplatform@wellcome.ac.uk')
        git('config', 'core.sshCommand', 'ssh -i deploy_key')

        git(
            'remote', 'add', 'ssh-origin',
            'git@github.com:wellcometrust/terraform-modules.git'
        )

        # Unencrypt the SSH key.
        subprocess.check_call([
            'openssl', 'aes-256-cbc',
            '-K', TRAVIS_KEY,
            '-iv', TRAVIS_IV,
            '-in', 'deploy_key.enc',
            '-out', 'deploy_key', '-d'
        ])
        subprocess.check_call(['chmod', '400', 'deploy_key'])

        # We checkout the branch before we add the commit, so we don't
        # include the merge commit that Travis makes.
        git('fetch', 'ssh-origin')
        git('checkout', branch)

        git('add', '--verbose', '--all')
        git('commit', '-m', 'Apply auto-formatting rules')
        git('push', 'ssh-origin', 'HEAD:%s' % branch)
    else:
        print('*** There were no changes from auto-formatting', flush=True)
