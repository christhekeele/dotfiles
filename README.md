# dotfiles

> _**My personal dotfiles for \*nixes**_

## Installation

Requirements: `git`, `rcm`, `sudo` access

Get my dotfiles à la:

```bash
git clone git@github.com:christhekeele/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update --recursive
```

They're made to work with the excellent dotfile manager [rcm](https://github.com/thoughtbot/rcm). After installing `rcm`, you can run `rcup` to link them into your home folder, or `rcup -t mac` to include OSX-specific goodies.

## Post-Installation

Running `rcup` for the first time will accidentally place this project's README and LICENSE in your home folder. (Later runs won't once the `.rcrc` is in place.) After your initial installation, prune them with `rm -f ~/.LICENSE.md ~/.README.md`.

## Contents

### Universal

- a `.rcrc` to ignore `*.md` files in the dotfiles directory
- a simple `.gemrc` that doesn't install documentation
- a simple `.railsrc` that prefers postgres
- my [Atom](https://atom.io) editor customizations
- a custom install of [prezto](https://github.com/sorin-ionescu/prezto), a [zsh](http://www.zsh.org/) framework, with handwritten battery indicator and git index prompt options
- a custom prezto theme using those features
- all my `zsh` runcoms
- a hook to set `zsh` as your default shell

### Mac

- a Brewfile that uses `brew` and `cask` to provision my go-to libraries and applications
- a hook to install `brew` and modify your `/etc/paths` to sate it
- a hook to execute the `Brewfile`
