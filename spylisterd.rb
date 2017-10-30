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

set :bind, "0.0.0.0"

redis = Redis.new

## Create Filebase

filebase = []
Find.find(settings.filebase) do |path|
  filebase.append(
      {
          :name => File.basename(path),
          :metadata => {
              :path => path
            }
        }) unless FileTest.directory?(path)
end

redis.set Socket.gethostname, filebase.to_json

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
    #send_file "#{filename}", :filename => filename, :type => 'Application/octet-stream'
    #redis.get(params["hostname"])
end
