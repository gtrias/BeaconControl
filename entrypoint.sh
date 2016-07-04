#!/bin/bash

cd /app
export RAILS_SERVE_STATIC_FILES=true
export RAILS_ENV=production
bin/rake db:create
bin/rake db:migrate
bundle exec rake assets:precompile
foreman start
