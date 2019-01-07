#!/usr/bin/env python
# -*- encoding: utf-8
"""
This script makes a rough attempt to spot unused variables in our Terraform modules.

It relies on the convention that variables are declared in `variables.tf`.
"""

import os
import sys

import hcl


unseen_vars_by_root  = {}

for root, _, filenames in os.walk("."):
    if "variables.tf" not in filenames:
        continue

    data = hcl.load(open(os.path.join(root, "variables.tf")))

    variable_names = list(data["variable"].keys())
    unseen_variable_names = set(variable_names)

    for f in filenames:
        # If we've seen every variable, we can skip straight to the
        # next directory.
        if not unseen_variable_names:
            break

        # Otherwise read the file and look for instances of any variable
        # we haven't seen being used yet.
        contents = open(os.path.join(root, f)).read()
        for varname in list(unseen_variable_names):
            if "var." + varname in contents:
                unseen_variable_names.remove(varname)

    if unseen_variable_names:
        unseen_vars_by_root[root] = unseen_variable_names


if unseen_vars_by_root:
    print("=== Unused variables ===\n")
    for root, unseen_variable_names in sorted(unseen_vars_by_root.items()):
        print(root)
        for varname in sorted(unseen_variable_names):
            print(f" * {varname}")
        print("")
    print("=== Unused variables ===")
    sys.exit(1)
