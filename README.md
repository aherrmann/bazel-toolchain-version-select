# Using transitions

Emulates regular compilation from x86_64 to x86_64 using compiler version 1:

```
$ bazel clean && bazel run //:hello_1_x86_64
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Version 1
! Running on x86_64 linux
! Targetting x86_64 linux
...
INFO: Running command line: bazel-out/k8-fastbuild-ST-6b3e419c2935/bin/hello_1_xINFO: Build completed successfully, 6 total actions
! Example program
! Compiled by version 1
! Compiled on x86_64 linux
! Running on x86_64 linux
Hello world
```

Emulates regular compilation from x86_64 to x86_64 using compiler version 2:

```
$ bazel clean && bazel run //:hello_2_x86_64
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Version 2
! Running on x86_64 linux
! Targetting x86_64 linux
...
INFO: Running command line: bazel-out/k8-fastbuild-ST-2c5ddf0f26b1/bin/hello_2_xINFO: Build completed successfully, 6 total actions
! Example program
! Compiled by version 2
! Compiled on x86_64 linux
! Running on x86_64 linux
Hello world
```

Emulates cross-compilation from x86_64 to arm using compiler version 1:

```
$ bazel clean && bazel run //:hello_1_arm
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Version 1
! Running on x86_64 linux
! Targetting arm linux
...
INFO: Running command line: bazel-out/k8-fastbuild-ST-e0a3cdaa9904/bin/hello_1_aINFO: Build completed successfully, 6 total actions
! Example program
! Compiled by version 1
! Compiled on x86_64 linux
! Running on arm linux
Hello world
```

Emulates cross-compilation from x86_64 to arm using compiler version 2:

```
$ bazel clean && bazel run //:hello_2_arm
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Version 2
! Running on x86_64 linux
! Targetting arm linux
...
INFO: Running command line: bazel-out/k8-fastbuild-ST-6cb406987aa8/bin/hello_2_aINFO: Build completed successfully, 6 total actions
! Example program
! Compiled by version 2
! Compiled on x86_64 linux
! Running on arm linux
Hello world
```

# Using platform and build setting flags

Emulates regular compilation from x86_64 to x86_64 using compiler version 1:

```
$ bazel run //:hello --platforms=//platforms:linux_x86_64 --//rules_example/version=1
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Version 1
! Running on x86_64 linux
! Targetting x86_64 linux
...
INFO: Build completed successfully, 3 total actions
! Example program
! Compiled by version 1
! Compiled on x86_64 linux
! Running on x86_64 linux
Hello world
```

Emulates regular compilation from x86_64 to x86_64 using compiler version 2:

```
$ bazel run //:hello --platforms=//platforms:linux_x86_64 --//rules_example/version=2
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Version 2
! Running on x86_64 linux
! Targetting x86_64 linux
...
INFO: Build completed successfully, 3 total actions
! Example program
! Compiled by version 2
! Compiled on x86_64 linux
! Running on x86_64 linux
Hello world
```

Emulates cross-compilation from x86_64 to arm using compiler version 1:

```
$ bazel run //:hello --platforms=//platforms:linux_arm --//rules_example/version=1
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Version 1
! Running on x86_64 linux
! Targetting arm linux
...
INFO: Build completed successfully, 2 total actions
! Example program
! Compiled by version 1
! Compiled on x86_64 linux
! Running on arm linux
Hello world
```

Emulates cross-compilation from x86_64 to arm using compiler version 2:

```
$ bazel run //:hello --platforms=//platforms:linux_arm --//rules_example/version=2
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Version 2
! Running on x86_64 linux
! Targetting arm linux
...
INFO: Build completed successfully, 2 total actions
! Example program
! Compiled by version 2
! Compiled on x86_64 linux
! Running on arm linux
Hello world
```
