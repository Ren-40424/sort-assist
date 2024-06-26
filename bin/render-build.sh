#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install

yarn vite build

bundle exec rake db:migrate