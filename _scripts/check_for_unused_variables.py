#!/usr/bin/env python
# -*- encoding: utf-8
"""
This script makes a rough attempt to spot unused variables in our Terraform modules.

It relies on the convention that variables are declared in `variables.tf`,
and will miss any variables declared elsewhere.
"""

import os
import re
import sys


unseen_vars_by_root  = {}

for root, _, filenames in os.walk("."):
    if "variables.tf" not in filenames:
        continue

    if ".terraform" in root:
        continue

    variables_path = os.path.join(root, "variables.tf")

    # Work out the list of variables defined in this file.  We use a proper
    # HCL parser if we can, but fall back to regexes if not.
    try:
        import hcl
    except ImportError:
        pass
        VARIABLE_RE = re.compile(r'^\s*variable "(?P<varname>[a-z0-9_]+)"\s*{')

        variable_names = []
        for line in open(variables_path):
            m = VARIABLE_RE.search(line)
            if m is not None:
                variable_names.append(m.group("varname"))
    else:
        data = hcl.load(open(variables_path))
        variable_names = list(data["variable"].keys())

    unseen_variable_names = set(variable_names)

    for f in filenames:
        # If we've seen every variable, we can skip straight to the
        # next directory.
        if not unseen_variable_names:
            break

        if not f.endswith(".tf"):
            continue

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
            print(" * " + varname)
        print("")
    print("=== Unused variables ===")
    sys.exit(1)
