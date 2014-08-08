#!/usr/bin/env bash

#
# Installation script for Vinter
#

echo "Installing Vinter"

# Backup local vim files
backupDir="${HOME}/.vinter-backup.$(date +%Y%m%dT%H%M%S)"
echo "Backing up all your old vim files to ${backupDir}"
mkdir ${backupDir}
mv ~/.vim* ${backupDir}

# Link vim files
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/vimrc.local ~/.vimrc.local
ln -s $(pwd)/vimrc.plugins ~/.vimrc.plugins

# Create local files
mkdir ~/.vim
touch ~/.vimrc.plugins.local

# Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install all plugins
vim -c "PluginInstall" -c "q" -c "q"

# Build the C extension for Command T
echo "Building the Command T C extension"
cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make

echo "Done with the installation. Happy hacking!"

exit 0
