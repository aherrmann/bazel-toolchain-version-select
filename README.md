Emulates regular compilation from x86_64 to x86_64:

```
$ bazel run //:hello --platforms=//platforms:linux_x86_64
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Running on x86_64 linux
! Targetting x86_64 linux
...
INFO: Build completed successfully, 5 total actions
! Example program
! Compiled on x86_64 linux
! Running on x86_64 linux
Hello world
```

Emulates cross-compilation from x86_64 to arm:

```
$ bazel run //:hello --platforms=//platforms:linux_arm
...
INFO: From Compiling Example binary hello.sh:
! Example compiler
! Running on x86_64 linux
! Targetting arm linux
...
INFO: Build completed successfully, 3 total actions
! Example program
! Compiled on x86_64 linux
! Running on arm linux
Hello world
```
