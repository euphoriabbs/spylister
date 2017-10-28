#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'rubygems'
require 'net-telnet'

localhost = Net::Telnet::new("Host" => "138.197.173.20", "Port" => 6023,
"Timeout" => 10)
localhost.login("username", "password") { |c| print c }
localhost.cmd("command") { |c| print c }
localhost.close