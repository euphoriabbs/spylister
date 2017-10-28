#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'rubygems'
require 'redis'
require 'json'

require 'sinatra'
require 'sinatra/contrib/all'

config_file 'spylister.yml'

redis = Redis.new

enable  :sessions, :logging

set :environment, :development

post '/' do
    redis.set 'foo', [1,2,3,4,5].to_json;
end

get '/' do
    JSON.parse redis.get('foo');
end
