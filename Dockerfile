ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

ARG BUNDLER_VERSION

RUN mkdir /app
WORKDIR /app

COPY Gemfile* ./
COPY dark_links.gemspec ./
COPY lib/dark_links/version.rb ./lib/dark_links/

RUN gem install bundler:$BUNDLER_VERSION
RUN bundle install -j20

COPY . ./
