#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'rubygems'
require 'redis'
require 'json'
require 'yaml'

require 'sinatra'
require 'sinatra/contrib/all'

config_file 'spylister.yml'

redis = Redis.new

enable  :sessions, :logging

set :environment, :development

redis.set 'foo', [1,2,3,4,5].to_json;

post '/api/v0/filelist' do
    #redis.set 'foo', [1,2,3,4,5].to_json;
end

get '/api/v0/filelist' do
    for bbs in redis.keys('*') do
        puts "#{bbs.to_json}"
        "#{JSON.parse redis.get bbs}"
    end
end
