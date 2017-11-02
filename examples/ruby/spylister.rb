#!/usr/bin/env ruby
# encoding: UTF-8

require "highline/import"
require "terminal-size"
require "rest-client"
require "json"

require "timers"
require "io/console"

# SpyLister Color Scheme

theme = HighLine::ColorScheme.new do |style|
    style[:title]           = [ :bold, :white, :on_black ]
    style[:headline]        = [ :bold, :white, :on_white ]
    style[:horizontal_line] = [ :bold, :white ]
    style[:footer]          = [ :bold, :green, :on_black ]
    style[:even_row]        = [ :blue ]
    style[:odd_row]         = [ :grey ]
    style[:winsize]         = [ :bold, :red, :on_grey ]
end

HighLine.color_scheme = theme

# SpyLister ANSI Artwork

def header_ansi

    system "clear" or system "cls"

    IO.readlines("spylister.ans").each do |line|
        puts line.force_encoding(Encoding::IBM437).encode(Encoding::UTF_8)
        #sleep 0.01
    end
end

header_ansi

# Get Nodes

nodes = RestClient.get "http://#{ARGV[0]}/api/v0/getnodes"
nodes = JSON.parse nodes.body

nodes.each do |node|
    node = RestClient.get "http://#{ARGV[0]}/api/v0/getnode/#{node}"

    #puts "\n#{name.capitalize} BBS Files"
    #say("<%= color('`'*79, :horizontal_line) %>")

    files = JSON.parse node

    switch = false

    console_counter = 0

    files.each do |file|
        console_counter += 1

        rows, columns = $stdin.winsize

        if switch == true
            say "<%= color('#{file.to_json[0..(columns - 1)]}', :even_row ) %>"
            switch = false
        else
            say "<%= color('#{file.to_json[0..(columns - 1)]}', :odd_row ) %>"
            switch = true
        end

        if console_counter >= (rows - 10)
            puts ""
            system "press-enter 8 green"
            console_counter = 0
            header_ansi
        end
    end
end
