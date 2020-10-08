#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require_relative 'workspace'

def main
  Dotenv.load

  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  option = nil

  until option == "quit" || option == "3"
    if option == "list users" || option == "1"
      puts workspace.list_users
    elsif option == "list channels" || option == "2"
      puts workspace.list_channels
    end
    menu
    option = gets.chomp
  end

  puts "Thank you for using the Ada Slack CLI"
end

def menu
  puts "Please select one of the three options: "
  puts "1. list users"
  puts "2. list channels"
  puts "3. quit"
end

main if __FILE__ == $PROGRAM_NAME