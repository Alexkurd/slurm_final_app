FROM ruby:2.7-alpine AS base
MAINTAINER massimo@it20.info
RUN apk add --no-cache --update \
  postgresql-dev \
  tzdata

FROM base AS dependencies

ENV LANG=en_us.UTF-8
ENV LC_ALL=C.UTF-8
ENV RACK_ENV=production

RUN apk add --no-cache --update build-base
COPY Gemfile ./

RUN gem install sinatra --no-document && \
    gem install aws-sdk-dynamodb --no-document && \
    bundle config set without "development test" && \
    bundle install --jobs=3 --retry=3
################## BEGIN INSTALLATION ######################

FROM base
# Set the working directory to /app
#RUN adduser -D app
#USER app
WORKDIR /app
COPY modules modules
COPY getvotes_adapter.rb getvotes_adapter.rb
COPY hostname_adapter.rb hostname_adapter.rb
COPY pageviews_adapter.rb pageviews_adapter.rb
COPY getstats_adapter.rb getstats_adapter.rb
COPY restaurant_adapter.rb restaurant_adapter.rb
COPY yelb-appserver.rb yelb-appserver.rb
COPY Gemfile Gemfile
# Set the working directory to /
WORKDIR /
COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/
#COPY ../yelb-db/init-yelb-db.sh /app/init-yelb-db.sh
COPY startup.sh startup.sh
ENV RACK_ENV=production
##################### INSTALLATION END #####################
CMD ["./startup.sh"]


