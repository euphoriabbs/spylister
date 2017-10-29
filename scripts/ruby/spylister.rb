#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require "rubygems"
require "json"
require "highline/import"
require "rest-client"

$r = RestClient.get "http://localhost:4567/api/v0/getsystems"

$systems = JSON.parse $r.body

$systems.each do |name|
    $r = RestClient.get "http://localhost:4567/api/v0/getsystem/#{name}"

    puts name

    $files = JSON.parse $r

    $files.each do |filename|
        puts filename.to_json
    end
end

#ask("Company?  ") { |q| q.default = "none" }
