FROM ruby:2.7.0-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh build-base postgresql-dev tzdata

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
ADD Gemfile* ./
RUN gem install bundler
RUN bundle install --jobs 8 --retry 5

# Copy the main application.
ADD . .
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start puma
CMD bundle exec rails s -p 3000 -b 0.0.0.0
