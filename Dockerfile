# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
RUN mkdir /app
WORKDIR /app

# WORKDIR /rails

# Set development environment
ENV RAILS_ENV="development" \
  BUNDLE_WITHOUT=""

# Install packages needed to build gems
# RUN apt-get update -qq && \
#   apt-get install --no-install-recommends -y build-essential git libvips pkg-config postgresql-client && \
#     rm -rf /var/lib/apt/lists /var/cache/apt/archives

  RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips libpq-dev pkg-config curl libvips redis postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile ./
RUN bundle install
# RUN gem install foreman

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
# RUN bundle exec bootsnap precompile app/ lib/

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
  chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["/app/bin/docker-dev-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3030
# CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3030"]