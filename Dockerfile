FROM ruby:2.2.4

RUN apt-get update

RUN apt-get install -y curl wget libpq-dev libpq5 libpqxx-4.0 \
        libpqxx-dev memcached nodejs nodejs-dev redis-server libxml2 libsasl2-2 \
        libxslt-dev libxml2-dev libgmp-dev libgmp3-dev libgmp10 libmysql++-dev \
        libmysqlclient-dev libmysqld-dev librtmp-dev \
        postgresql-client postgresql-client-common git

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

ADD . /app
WORKDIR /app

RUN bundle install

ENTRYPOINT foreman start
