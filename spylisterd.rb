#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require "rubygems"
require "redis"
require "json"

require "sinatra"
require "sinatra/contrib/all"

config_file "server.yml"

redis = Redis.new

enable  :sessions, :logging

set :environment, :development

redis.set "foo", [
    { :name => "something1.zip", :size => 1232},
    { :name => "something2.zip", :size => 1232},
    { :name => "something3.zip", :size => 1232},
    { :name => "something4.zip", :size => 1232},
    { :name => "something5.zip", :size => 1232}
].to_json

redis.set "euphoria", [
    { :name => "something1.zip", :size => 1232},
    { :name => "something2.zip", :size => 1232},
    { :name => "something3.zip", :size => 1232},
    { :name => "something4.zip", :size => 1232},
    { :name => "something5.zip", :size => 1232}
].to_json

get "/api/v0/getsystems" do
    content_type :json
    redis.keys("*").to_json
end

get "/api/v0/getsystem/:name" do
    content_type :json
    redis.get(params["name"])
end
