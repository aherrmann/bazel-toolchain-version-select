_example_compiler_template = """\
#!/usr/bin/env bash
set -euo pipefail
# USAGE: compiler OUT MESSAGE
cat >&2 <<EOF
! Example compiler
! Running on {EXEC_CPU} {EXEC_OS}
! Targetting {TARGET_CPU} {TARGET_OS}
EOF
cat >"$1" <<EOF
#!/usr/bin/env bash
set -euo pipefail
echo >&2 '! Example program'
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
