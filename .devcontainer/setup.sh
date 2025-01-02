#!/bin/bash

# Initialize rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Install Ruby 3.2.0 if not already installed
if ! rbenv versions | grep -q "3.2.0"; then
  rbenv install 3.2.0
fi

# Set Ruby 3.2.0 as the default
rbenv global 3.2.0
rbenv rehash

# Install the curses gem
gem install curses