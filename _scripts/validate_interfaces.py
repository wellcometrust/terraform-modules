#!/usr/bin/env python
# -*- encoding: utf-8

import os
import sys

import attr
import hcl


@attr.s
class TerraformModule:
    root = attr.ib()
    referenced_modules = attr.ib()
    variables = attr.ib()


# STEP 1
#
# Build a list of all the modules in the repository: their root path,
# the modules they reference, and the variables they require.

modules_by_root = {}

for root, _, filenames in os.walk("."):

    # We're only interested in modules, so skip anything else
    if not any(f.endswith(".tf") for f in filenames):
        continue
    if ".git" in root:
        continue

    # Now get a list of all the attributes of this module.
    referenced_modules = []
    variables = []
    for f in filenames:
        if not f.endswith(".tf"):
            continue

        path = os.path.join(root, f)

        try:
            terraform = hcl.load(open(path))
        except ValueError:
            print(path)
            raise

        referenced_modules.extend(list(terraform.get("module", {}).items()))
        variables.extend(list(terraform.get("variable", {}).items()))

    module = TerraformModule(
        root=root,
        referenced_modules=referenced_modules,
        variables=variables
    )

    modules_by_root[root.lstrip("./")] = module



# STEP 2
#
# Go through all the modules in the repo, and check if they reference any
# modules by the wrong variables.

seen_errors = False

for root, root_module in modules_by_root.items():

    # If this module doesn't refer to any modules, we can skip past it.
    if not root_module.referenced_modules:
        continue

    for name, module_usage in root_module.referenced_modules:
        m_root = os.path.normpath(os.path.join(root, module_usage["source"]))

        try:
            module = modules_by_root[m_root]
        except KeyError:
            print("!!! %s in %s refers to non-existent module %s" % (
                name, root, m_root
            ))
            seen_errors = True
            continue

        # Check all the (non-default) variables defined by this module
        # are included in the usage here.
        for var_name, var_data in module.variables:
            if "default" in var_data:
                continue
            if var_name not in module_usage:
                print("!!! %s in %s is missing %s variable" % (
                    name, root, var_name
                ))
                seen_errors = True

        # Check the usage isn't including any variables that aren't defined.
        variable_names = [v[0] for v in module.variables]
        for var_name in module_usage:
            if var_name == "source":
                continue
            if var_name not in variable_names:
                print("!!! %s in %s refers to non-existent variable %s" % (
                    name, root, var_name
                ))
                seen_errors = True

if seen_errors:
    sys.exit(1)
else:
    sys.exit(0)
