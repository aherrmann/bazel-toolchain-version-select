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
$ bazel run //:hello --platforms=//platforms:linux_arm --//rules_example/version
=1
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
