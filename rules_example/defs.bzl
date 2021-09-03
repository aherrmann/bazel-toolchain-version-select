load("@bazel_skylib//lib:paths.bzl", "paths")

# --------------------------------------------------------------------
# Toolchain

_example_compiler_template = """\
#!/usr/bin/env bash
set -euo pipefail
# USAGE: compiler OUT MESSAGE
cat >&2 <<EOF
! Example compiler
! Version {VERSION}
! Running on {EXEC_CPU} {EXEC_OS}
! Targetting {TARGET_CPU} {TARGET_OS}
EOF
cat >"$1" <<EOF
#!/usr/bin/env bash
set -euo pipefail
echo >&2 '! Example program'
echo >&2 '! Compiled by version {VERSION}'
echo >&2 '! Compiled on {EXEC_CPU} {EXEC_OS}'
echo >&2 '! Running on {TARGET_CPU} {TARGET_OS}'
echo "${{@:2}}"
EOF
chmod +x "$1"
"""

def _example_compiler_impl(ctx):
    executable = ctx.actions.declare_file("{}.sh".format(ctx.label.name))
    ctx.actions.write(
        executable,
        is_executable = True,
        content = _example_compiler_template.format(
            VERSION = ctx.attr.version,
            EXEC_CPU = ctx.attr.exec_cpu.label.name,
            EXEC_OS = ctx.attr.exec_os.label.name,
            TARGET_CPU = ctx.attr.target_cpu.label.name,
            TARGET_OS = ctx.attr.target_os.label.name,
        ),
    )
    return [DefaultInfo(
        executable = executable,
        files = depset(direct = [executable]),
    )]

example_compiler = rule(
    _example_compiler_impl,
    attrs = {
        "version": attr.string(mandatory = True),
        "exec_cpu": attr.label(),
        "exec_os": attr.label(),
        "target_cpu": attr.label(),
        "target_os": attr.label(),
    },
    executable = True,
)

ExampleToolchainInfo = provider()

def _example_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        example_info = ExampleToolchainInfo(compiler = ctx.executable.compiler),
    )
    return [toolchain_info]

example_toolchain = rule(
    _example_toolchain_impl,
    attrs = {
        "compiler": attr.label(
            executable = True,
            cfg = "host",
        ),
    },
)

# --------------------------------------------------------------------
# Rules

def _example_binary_impl(ctx):
    executable = ctx.actions.declare_file("{}.sh".format(ctx.label.name))
    ctx.actions.run(
        outputs = [executable],
        inputs = [],
        executable = ctx.toolchains["//rules_example:toolchain_type"].example_info.compiler,
        arguments = [executable.path, ctx.attr.message],
        mnemonic = "ExampleCompileSimple",
        progress_message = "Compiling Example binary {}".format(executable.short_path),
    )
    return [DefaultInfo(
        executable = executable,
        files = depset(direct = [executable]),
    )]

example_binary = rule(
    _example_binary_impl,
    attrs = {
        "message": attr.string(),
    },
    executable = True,
    toolchains = ["//rules_example:toolchain_type"],
)

# --------------------------------------------------------------------
# Transitions

def _example_transition_impl(settings, attr):
    platform = attr.platform
    compiler_version = attr.compiler_version
    return {
        "//command_line_option:platforms": platform,
        "//rules_example/version": compiler_version,
    }

example_transition = transition(
    implementation = _example_transition_impl,
    inputs = [],
    outputs = [
        "//command_line_option:platforms",
        "//rules_example/version",
    ],
)

def _example_transition_binary_impl(ctx):
    (_, extension) = paths.split_extension(ctx.executable.executable.path)
    executable = ctx.actions.declare_file(
        ctx.label.name + extension,
    )
    ctx.actions.symlink(
        output = executable,
        target_file = ctx.executable.executable,
        is_executable = True,
    )

    runfiles = ctx.runfiles(files = [executable, ctx.executable.executable] + ctx.files.data)
    runfiles = runfiles.merge(ctx.attr.executable[DefaultInfo].default_runfiles)
    for data_dep in ctx.attr.data:
        runfiles = runfiles.merge(data_dep[DefaultInfo].default_runfiles)

    return [DefaultInfo(
        executable = executable,
        files = depset(direct = [executable]),
        runfiles = runfiles,
    )]

example_transition_binary = rule(
    _example_transition_binary_impl,
    attrs = {
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
        "data": attr.label_list(allow_files = True),
        "platform": attr.string(mandatory = True),
        "compiler_version": attr.string(mandatory = True),
        "executable": attr.label(
            cfg = "target",
            executable = True,
        ),
    },
    cfg = example_transition,
    executable = True,
)
