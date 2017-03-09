# hello-reflex
A simple template for reflex projects

## Clone the repository
```shell
git clone git@github.com:daig/hello-reflex
```

## Install the [nix package manager](https://nixos.org/nix/)
We use nix to handle our builds
```shell
curl https://nixos.org/nix/install | sh
. $HOME/.nix-profile/etc/profile.d/nix.sh
```
### Make sure the nix environment is set up
If you are not using `bash` (for example, you are using [`zsh`](ohmyz.sh)), then you will need to add the above `nix.sh` to your respective `.*rc` file.
For example, for `zsh`:
```shell
echo 'source $HOME/.nix-profile/etc/profile.d/nix.sh' >> .zshrc
```

## Initiallize [submodules](https://git-scm.com/docs/git-submodule) for  [`reflex-platform`](https://github.com/reflex-frp/reflex-platform)
We use `reflex-platform` to generate the necessary `nix` configuration from our `.cabal` file, and to assist with `reflex` and [`ghcjs`](https://github.com/ghcjs/ghcjs) dependencies
So update the [submodules](https://git-scm.com/docs/git-submodule) containing `reflex-platform`
```shell
git submodule update --init --recursive
```

## Build the project
Normally, you will build it like:
```shell
nix-build build.nix
```
However, the first build may take a long time fetching dependencies for reflex. You can speed it up by downloading precompiled binaries instead of building from scratch:
```shell
nix-build --option binary-caches https://nixcache.reflex-frp.org build.nix
```

Both options will create a symlinked folder `result`. `result/bin/hello-reflex.jsexe`contains everything you need to server the resulting page

simply open `result/bin/hello-reflex.jsexe/index.html` in your favorite browser to see the result!

### Build an executable with ghc
You may instead want to build a local application with ghc, rather than ghcjs. To do so, simply change `ghcjs` to `ghc` in the `build.nix` file.
This can be good for development, since ghc currently builds significantly faster than ghcjs, particularly for projects with a lot of template haskell
Note however that the ghc application is less stable than the ghcjs version and may not work for projects using complex dom features.

## Develop your project!
To extend this template, simply add code and modify the `.cabal` file
accordingly, as you would normally.

To put yourself into a development environment, run
```shell
deps/reflex-platform/work-on ghc ./.
```
This will put you in a nix environment with all the dependencies specified in
the cabal file installed. Which should be suitible for any haskell development
tools you may use.

In particular, from inside the nix shell, you can run
```shell
cabal repl
```
to enter `ghci` for the project. `work-on ghc` uses regular old ghci so it builds much faster for testing.


## Improve this template
If you run into any difficulties not covered here, or think of a useful way to improve this template please file an issue [here](https://github.com/daig/hello-reflex/issues)

As always, feel free to create a merge request with any additional features you've built up
