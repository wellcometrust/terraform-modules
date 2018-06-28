# coding=utf-8
#
# This file is part of Hypothesis, which may be found at
# https://github.com/HypothesisWorks/hypothesis-python
#
# Most of this work is copyright (C) 2013-2017 David R. MacIver
# (david@drmaciver.com), but it contains contributions by others. See
# CONTRIBUTING.rst for a full list of people who may hold copyright, and
# consult the git log if you need to determine who owns an individual
# contribution.
#
# This Source Code Form is subject to the terms of the Mozilla Public License,
# v. 2.0. If a copy of the MPL was not distributed with this file, You can
# obtain one at http://mozilla.org/MPL/2.0/.
#
# END HEADER

from __future__ import division, print_function, absolute_import

import os
import re
import sys
import subprocess
from datetime import datetime, timedelta

from config import REPO_NAME


def tags():
    result = [t.decode('ascii') for t in subprocess.check_output([
        'git', 'tag'
    ]).split(b"\n")]
    assert len(set(result)) == len(result)

    return set(result)


ROOT = subprocess.check_output([
    'git', 'rev-parse', '--show-toplevel']).decode('ascii').strip()


def latest_version():
    versions = []

    for t in tags():
        # All versions get tags but not all tags are versions (and there are
        # a large number of historic tags with a different format for versions)
        # so we parse each tag as a triple of ints (MAJOR, MINOR, PATCH)
        # and skip any tag that doesn't match that.
        assert t == t.strip()
        parts = t.split('.')
        if len(parts) != 3:
            continue
        parts[0] = parts[0].lstrip('v')
        try:
            v = tuple(map(int, parts))
        except ValueError:
            continue

        versions.append((v, t))

    _, latest = max(versions)

    assert latest in tags()
    return latest


__version__ = None
__version_info__ = None

__version__ = latest_version()
__version_info__ = [int(i) for i in __version__.lstrip('v').split('.')]

assert __version__ is not None
assert __version_info__ is not None


def hash_for_name(name):
    return subprocess.check_output([
        'git', 'rev-parse', name
    ]).decode('ascii').strip()


def is_ancestor(a, b):
    check = subprocess.call([
        'git', 'merge-base', '--is-ancestor', a, b
    ])
    assert 0 <= check <= 1
    return check == 0


CHANGELOG_FILE = os.path.join(ROOT, 'CHANGELOG.md')


def changelog():
    with open(CHANGELOG_FILE) as i:
        return i.read()


def git(*args):
    subprocess.check_call(('git',) + args)


def create_tag_and_push():
    assert __version__ not in tags()
    git('config', 'user.name', 'Travis CI on behalf of Wellcome')
    git('config', 'user.email', 'wellcomedigitalplatform@wellcome.ac.uk')
    git('config', 'core.sshCommand', 'ssh -i deploy_key')
    git(
        'remote', 'add', 'ssh-origin',
        'git@github.com:wellcometrust/%s.git' % REPO_NAME
    )
    git('tag', __version__)

    subprocess.check_call(['git', 'push', 'ssh-origin', 'HEAD:master'])
    subprocess.check_call(['git', 'push', 'ssh-origin', '--tags'])


def modified_files():
    files = set()
    for command in [
        ['git', 'diff', '--name-only', '--diff-filter=d',
            latest_version(), 'HEAD'],
        ['git', 'diff', '--name-only']
    ]:
        diff_output = subprocess.check_output(command).decode('ascii')
        for l in diff_output.split('\n'):
            filepath = l.strip()
            if filepath:
                assert os.path.exists(filepath)
                files.add(filepath)
    return files


RELEASE_FILE = os.path.join(ROOT, 'RELEASE.md')


def has_release():
    return os.path.exists(RELEASE_FILE)


CHANGELOG_HEADER = re.compile(r"^## v\d+\.\d+\.\d+ - \d\d\d\d-\d\d-\d\d$")
RELEASE_TYPE = re.compile(r"^RELEASE_TYPE: +(major|minor|patch)")


MAJOR = 'major'
MINOR = 'minor'
PATCH = 'patch'

VALID_RELEASE_TYPES = (MAJOR, MINOR, PATCH)


def parse_release_file():
    with open(RELEASE_FILE) as i:
        release_contents = i.read()

    release_lines = release_contents.split('\n')

    m = RELEASE_TYPE.match(release_lines[0])
    if m is not None:
        release_type = m.group(1)
        if release_type not in VALID_RELEASE_TYPES:
            print('Unrecognised release type %r' % (release_type,))
            sys.exit(1)
        del release_lines[0]
        release_contents = '\n'.join(release_lines).strip()
    else:
        print(
            'RELEASE.md does not start by specifying release type. The first '
            'line of the file should be RELEASE_TYPE: followed by one of '
            'major, minor, or patch, to specify the type of release that '
            'this is (i.e. which version number to increment). Instead the '
            'first line was %r' % (release_lines[0],)
        )
        sys.exit(1)

    return release_type, release_contents


def update_changelog_and_version():
    global __version_info__
    global __version__

    with open(CHANGELOG_FILE) as i:
        contents = i.read()
    assert '\r' not in contents
    lines = contents.split('\n')
    assert contents == '\n'.join(lines)
    for i, l in enumerate(lines):
        if CHANGELOG_HEADER.match(l):
            beginning = '\n'.join(lines[:i])
            rest = '\n'.join(lines[i:])
            assert '\n'.join((beginning, rest)) == contents
            break

    release_type, release_contents = parse_release_file()

    new_version = list(__version_info__)
    bump = VALID_RELEASE_TYPES.index(release_type)
    new_version[bump] += 1
    for i in range(bump + 1, len(new_version)):
        new_version[i] = 0
    new_version = tuple(new_version)
    new_version_string = 'v' + '.'.join(map(str, new_version))

    now = datetime.utcnow()

    date = max([
        d.strftime('%Y-%m-%d') for d in (now, now + timedelta(hours=1))
    ])

    heading_for_new_version = '## ' + ' - '.join((new_version_string, date))

    new_changelog_parts = [
        beginning.strip(),
        '',
        heading_for_new_version,
        '',
        release_contents,
        '',
        rest
    ]

    with open(CHANGELOG_FILE, 'w') as o:
        o.write('\n'.join(new_changelog_parts))


def update_for_pending_release():
    git('config', 'user.name', 'Travis CI on behalf of Wellcome')
    git('config', 'user.email', 'wellcomedigitalplatform@wellcome.ac.uk')
    update_changelog_and_version()

    git('rm', RELEASE_FILE)
    git('add', CHANGELOG_FILE)

    git(
        'commit',
        '-m', 'Bump version to %s and update changelog' % (__version__,)
    )


def changed_files(*args):
    """
    Returns a set of changed files in a given commit range.

    :param commit_range: Arguments to pass to ``git diff``.
    """
    files = set()
    command = ['git', 'diff', '--name-only'] + list(args)
    diff_output = subprocess.check_output(command).decode('ascii')
    for line in diff_output.splitlines():
        filepath = line.strip()
        if filepath:
            files.add(filepath)
    return files


def make(task, dry_run=False):
    if dry_run:
        command = ['make', '--dry-run', task]
    else:
        command = ['make', task]
    print('*** Running %r' % command, flush=True)
    subprocess.check_call(command)
