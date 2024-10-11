ARG RUBY_VERSION='3.1.1'
FROM ruby:$RUBY_VERSION

ARG BUNDLER_VERSION='2.1.4'

RUN mkdir /app
WORKDIR /app

COPY Gemfile* ./
COPY dark_links.gemspec ./
COPY lib/dark_links/version.rb ./lib/dark_links/

RUN gem install bundler:$BUNDLER_VERSION
RUN bundle install -j20

COPY . ./
