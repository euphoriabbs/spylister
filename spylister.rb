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

post '/api/v0/filelist' do
    redis.set 'foo', [1,2,3,4,5].to_json;
end

get '/api/v0/filelist' do
    if params['format'] == "json"
        JSON.parse redis.keys '*'.to_json;
    end
    if params['format'] == "yaml"
        JSON.parse redis.keys '*'.to_yaml;
    end
end
