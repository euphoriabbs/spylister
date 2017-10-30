#!/usr/bin/env ruby
# encoding: UTF-8

require "digest"
require "socket"
require "redis"
require "json"
require "find"

require "sinatra"
require "sinatra/contrib/all"

# Setup

config_file "spylisterd.yml"

enable  :sessions, :logging

set :environment, :development

set :bind, '0.0.0.0'

redis = Redis.new

pathes = []
Find.find(settings.filebase) do |path|
  pathes << path unless FileTest.directory?(path)
end

redis.set Socket.gethostname, pathes.to_json

# API

get "/api/v0/getnodes" do
    content_type :json
    redis.keys("*").to_json
end

get "/api/v0/getnode/:hostname" do
    content_type :json
    redis.get(params["hostname"])
end

get "/api/v0/getnode/:hostname/:filename" do
    content_type :json
    #redis.get(params["hostname"])
end
