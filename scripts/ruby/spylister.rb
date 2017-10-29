#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require "rubygems"
require "json"
require "highline/import"
require "rest-client"

ft = HighLine::ColorScheme.new do |cs|
    cs[:headline]        = [ :bold, :yellow, :on_black ]
    cs[:horizontal_line] = [ :bold, :white ]
    cs[:even_row]        = [ :green ]
    cs[:odd_row]         = [ :magenta ]
  end

HighLine.color_scheme = ft
say("<%= color('SpyLister 3', :headline) %>")
say("<%= color('-'*20, :horizontal_line) %>")
i = true
("A".."D").each do |row|
if i then
  say("<%= color('#{row}', :even_row ) %>")
else
  say("<%= color('#{row}', :odd_row) %>")
end
i = !i
end
$r = RestClient.get "http://138.197.173.20:4567/api/v0/getsystems"

$systems = JSON.parse $r.body

$systems.each do |name|
    $r = RestClient.get "http://138.197.173.20:4567/api/v0/getsystem/#{name}"

    puts name

    $files = JSON.parse $r

    $files.each do |filename|
        puts filename.to_json
    end
end

#ask("Company?  ") { |q| q.default = "none" }
