#!/usr/bin/env ruby
# encoding: UTF-8

require "highline/import"
require "terminal-size"
require "rest-client"
require "json"
require "yaml"

# Color Scheme
theme = HighLine::ColorScheme.new do |style|
    style[:title]              = [ :bold, :white, :on_black ]
    style[:headline]           = [ :bold, :white, :on_white ]
    style[:horizontal_line]    = [ :bold, :white ]
    style[:footer]             = [ :bold, :green, :on_black ]
    style[:even_row]           = [ :blue ]
    style[:odd_row]            = [ :grey ]
end

HighLine.color_scheme = theme

# Header ANSI

system "clear" or system "cls"

IO.readlines("spylister.ans").each do |line|
    puts line.force_encoding(Encoding::IBM437).encode(Encoding::UTF_8)
    sleep 0.01
end

# Prints a combination of the progress bar, spinner, and percentage examples.
spinner = Enumerator.new do |e|
    loop do
        e.yield '|'
        e.yield '/'
        e.yield '-'
        e.yield '\\'
    end
end

1.upto 100 do |i|
    progress = "=" * (i/5) unless i < 5
    printf "\rIndexing: [%-20s] %d%% %s", progress, i, spinner.next
    sleep 0.05
end
printf "\r                                           "

# File Content

nodes = RestClient.get "http://#{ARGV[0]}/api/v0/getnodes"

systems = JSON.parse nodes.body

puts "\r"

systems.each do |name|
    node = RestClient.get "http://#{ARGV[0]}/api/v0/getnode/#{name}"

    #puts "\n#{name.capitalize} BBS Files"
    #say("<%= color('`'*79, :horizontal_line) %>")

    files = JSON.parse node

    switch = false

    files.each do |filename|

        if switch == true
            say "<%= color('#{filename.to_json}', :even_row ) %>"
            switch = false
        else
            say "<%= color('#{filename.to_json}', :odd_row ) %>"
            switch = true
        end
    end
end

puts ""
ask("<%= color('Ready to quit?', :footer) %> ") { |q| q.default = "quit" }
