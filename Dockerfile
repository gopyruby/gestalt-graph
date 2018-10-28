FROM ruby:2.3

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Extended from https://hub.docker.com/_/ruby/@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#  NOTES:
#    - This will not work with volumes, uid:gid won't match.
#      - There are workarounds for this
#    - Can eventually be migrated to use docker-compose.
#      - For simplicities sake and to get the app running, this PoC Dockerfile was created.
#    - Does not install neo4j

RUN bundle config --global frozen 1 &&\
    mkdir /usr/src/app &&\
    useradd appuser -d /usr/src/app &&\
    chown appuser:appuser /usr/src/app

USER appuser

WORKDIR /usr/src/app

# Leverage caching of gems
COPY Gemfile Gemfile.lock ./
RUN bundle install 

COPY --chown=appuser:appuser . .

CMD ["rails", "s"]

