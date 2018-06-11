# -*- encoding: utf-8

from hypothesistooling import modified_files


REPO_NAME = 'terraform-modules'


def has_source_changes(version=None):
    if version is None:
        version = latest_version()

    tf_files = [
        f for f in modified_files() if f.strip().endswith('.tf')
    ]
    return len(tf_files) != 0
