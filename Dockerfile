FROM ruby:2.7.2-alpine

RUN apk add --no-cache --update build-base \
                                postgresql-dev \
                                git \
                                sqlite-dev \
                                tzdata \
                                vim \
                                less \
                                && rm -rf /var/cache/apk/*

RUN addgroup --gid 1000 -S deploy && adduser --uid 1000 -S deploy -G deploy
USER deploy
RUN mkdir -p /home/deploy/app
WORKDIR /home/deploy/app
ENV GEM_HOME=/home/deploy/app/.bundle/ruby/2.7.0
ENV PATH=/home/deploy/app/.bundle/ruby/2.7.0/bin:$PATH

EXPOSE 3000
CMD rm tmp/pids/server.pid; bundle exec rails server -b 0.0.0.0 -p 3000
