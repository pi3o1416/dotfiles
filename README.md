# Dotfiles

## Introduction
This repository contains configuration files to set up a Neovim-based development environment. It is designed to provide a smooth and efficient coding experience with enhanced features such as code linting, formatting, language server protocol (LSP) integration, and more.

## Overview
This repository includes
  * **init.lua** The main configuration file for Neovim, including plugin management, language settings, keybindings, and more.
  * **.tmux.conf**: The main configuration for tmux. including plugin management keybinding etc.

## Prerequisite
  * Install `neovim`
  * Install `tmux`


## Setup
  * Make sure you are in home directory
  * `git init`
  * `git remote add origin git@github.com:pi3o1416/dotfiles.git`
  * `git pull origin nvim-lua`
  * Open a tmux session and press <prefix> + I (captil i) to install plugins. tmux plugin require xclp or xsel pre-installed to copy to the system clipboard
  * Install tmux-themepack
  * Install tpm for tmux
  * Install `pynvim`
    * **Arch Linux**: `sudo pacman -S python-pynvim`
  * Open nvim it will autometically install all the packages
  * Install tpm for tmux
