RELEASE_TYPE: major

This is a collection of changes to support Terraform 0.12.
All the modules should still work with Terraform 0.11, but there are some breaking changes that will require code changes.

Breaking changes:

*   `api_gateway/modules/stage`: the variable `depends_on` is now `dependencies`

Internal renaming, which might require a `terraform state mv`:

*   `api_gateway/prebuilt/method/static`: no external changes

Internal-only changes, should be invisible:

*   `ecs/modules/service/prebuilt/scaling`

These changes should be backwards compatible with terraform 0.11.14.
