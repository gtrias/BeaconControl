FROM ubuntu:14.04

RUN echo rvm_auto_reload_flag=2 >> ~/.rvmrc

RUN apt-get update

RUN apt-get install -y curl wget libpq-dev libpq5 libpqxx-4.0 \
        libpqxx-dev memcached nodejs nodejs-dev redis-server libxml2 libsasl2-2 \
        libxslt-dev libxml2-dev libgmp-dev libgmp3-dev libgmp10 libmysql++-dev \
        libmysqlclient-dev libmysqld-dev librtmp-dev \
        postgresql-client postgresql-client-common git

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

ADD . /app

# install RVM
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "cd /app && rvm requirements"
RUN /bin/bash -l -c "cd /app && rvm install 2.2.4"

RUN cd /app && echo "2.2.4" > .ruby-version

RUN cd /app && echo "beacon" > .ruby-gemset

RUN /bin/bash -l -c "rvm use 2.2.4@beacon --create"

RUN /bin/bash -l -c "cd /app && gem install bundle && bundle install"

# RUN /bin/bash -l -c "cd /app && bin/setup && bin/rake db:create db:migrate && bin/rake db:seed"
# ENTRYPOINT ["/app/entrypoint.sh"]
# CMD ["/app/entrypoint.sh"]
CMD ["ping", "localhost"]
