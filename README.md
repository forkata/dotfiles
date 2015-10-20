dotfiles
========

## Clone

Clone into a folder on your computer

```
git clone git@github.com:forkata/dotfiles.git ~/dotfiles
```

Initialize prezto submodule

```
cd ~/dotfiles
git submodule update --init
```
## Install

Symlink the files, _note_ this will overwrite any matching files in your home
folder so you might want to move them out of the way

```
./bootstrap.sh
```

## Updating prezto
```
cd .zprezto
git pull && git submodule update --init --recursive
```
