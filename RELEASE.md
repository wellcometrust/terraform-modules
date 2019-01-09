RELEASE_TYPE: major

This release removes a bunch of variables from modules when they weren't
being used by the module code, and adds a script to prevent unused variables
creeping back in later.