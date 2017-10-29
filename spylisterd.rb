#!/usr/bin/env ruby
# encoding: UTF-8

require "rubygems"
require "redis"
require "json"
require "timers"

require "sinatra"
require "sinatra/contrib/all"

config_file "spylisterd.yml"

redis = Redis.new

enable  :sessions, :logging

set :environment, :development

set :bind, '0.0.0.0'

redis.set "foo", [
    { :name => "something1.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something2.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something3.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something4.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something5.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something6.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something7.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something8.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232}

].to_json

redis.set "euphoria", [
    { :name => "something1.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something2.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something3.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232},
    { :name => "something4.zip", :description => "Minim ad ea dolore sit tempor commodo ullamco sunt.", :size => 1232}

].to_json

get "/api/v0/getnodes" do
    content_type :json
    redis.keys("*").to_json
end

get "/api/v0/getnode/:name" do
    content_type :json
    redis.get(params["name"])
end

#timers = Timers::Group.new

#timers.now_and_every(5) { puts "Another 5 seconds" }

#loop { timers.wait }