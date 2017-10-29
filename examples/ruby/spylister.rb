#!/usr/bin/env ruby
# encoding: UTF-8

require "rubygems"
require "json"
require "highline/import"
require "rest-client"
require "terminal-size"

ft = HighLine::ColorScheme.new do |cs|
    cs[:title]        = [ :bold, :white, :on_black ]
    cs[:headline]        = [ :bold, :white, :on_white ]
    cs[:horizontal_line] = [ :bold, :white ]
    cs[:footer]        = [ :bold, :green, :on_black ]
    cs[:even_row]        = [ :blue ]
    cs[:odd_row]         = [ :grey ]
end

HighLine.color_scheme = ft

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

$r = RestClient.get "http://138.197.173.20:4567/api/v0/getsystems"

$systems = JSON.parse $r.body

puts "\r"

$systems.each do |name|
    $r = RestClient.get "http://138.197.173.20:4567/api/v0/getsystem/#{name}"

    #puts "\n#{name.capitalize} BBS Files"
    #say("<%= color('`'*79, :horizontal_line) %>")

    $files = JSON.parse $r

    $switch = false

    $files.each do |filename|

        if $switch == true
            say "<%= color('#{filename.to_json}', :even_row ) %>"
            $switch = false
        else
            say "<%= color('#{filename.to_json}', :odd_row ) %>"
            $switch = true
        end
    end
end

puts ""
ask("<%= color('Ready to quit?', :footer) %> ") { |q| q.default = "quit" }
