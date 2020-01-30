FROM ruby:2.7.0-alpine
ENV LANG C.UTF-8

RUN gem install bundler

ENV APP_HOME /myapp
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME 
