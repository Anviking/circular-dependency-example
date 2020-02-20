# Circular dependency example

```bash
stack test                                                                                                                                                                                                                                                                                        (5s 386ms)
core> build (test)
core> Preprocessing library for core-0.1.0.0..
core> Building library for core-0.1.0.0..
core> Preprocessing test suite 'unit' for core-0.1.0.0..
core> Building test suite 'unit' for core-0.1.0.0..
core> [1 of 1] Compiling Spec
core>
core> /private/tmp/core/core/test/Spec.hs:7:19: error:
core>     ¥ Couldn't match expected type ÔColorÕ
core>                   with actual type Ôcore-0.1.0.0:Core.ColorÕ
core>       NB: Ôcore-0.1.0.0:Core.ColorÕ
core>             is defined in ÔCoreÕ in package Ôcore-0.1.0.0Õ
core>           ÔColorÕ is defined in ÔCoreÕ in package Ôcore-0.1.0.0Õ
core>     ¥ In the first argument of ÔprintColorÕ, namely ÔarbitraryColorÕ
core>       In the expression: printColor arbitraryColor
core>       In an equation for ÔmainÕ: main = printColor arbitraryColor
core>   |
core> 7 | main = printColor arbitraryColor
core>   |                   ^^^^^^^^^^^^^^
core>
```

```bash
cabal new-test core                                                                                                                                                                                                                                                 (1) (6s 788ms)
Resolving dependencies...
cabal: Could not resolve dependencies:
[__0] next goal: core (user goal)
[__0] rejecting: core-0.5, core-0.4, core-0.3, core-0.2 (constraint from user
target requires ==0.1.0.0)
[__0] trying: core-0.1.0.0
[__1] next goal: util (user goal)
[__1] rejecting: util-0.1.17.1, util-0.1.17.0, util-0.1.16.0, util-0.1.15.0,
util-0.1.14.1, util-0.1.14.0, util-0.1.13.0, util-0.1.12.0, util-0.1.11.0,
util-0.1.10.1, util-0.1.10.0, util-0.1.9.0, util-0.1.8.0, util-0.1.7.0,
util-0.1.6.0, util-0.1.5.0, util-0.1.4.0, util-0.1.3.0, util-0.1.2.1,
util-0.1.2.0, util-0.1.1.0 (constraint from user target requires ==0.1.0.0)
[__1] trying: util-0.1.0.0
[__2] rejecting: core:*test (cyclic dependencies; conflict set: core, util)
[__1] fail (backjumping, conflict set: core, util)
After searching the rest of the dependency tree exhaustively, these were the
goals I've had most trouble fulfilling: util, core
```

## Known alternative

Defining `util` as an internal library inside `core` is an option. Sadly it looks like it
breaks `stack --haddock`. https://github.com/haskell/cabal/issues/1919
