#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
#require 'table_print'
require_relative 'workspace'

def main
  Dotenv.load

  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  option = nil
  current_selection = nil
  until option == "quit" || option == "7"
    if option == "list users" || option == "1"
      puts workspace.list_users
    elsif option == "list channels" || option == "2"
      puts workspace.list_channels
    elsif option == "select user" || option == "3"
      puts "Enter the name or id"
      current_selection = workspace.select("user",gets.chomp)
      puts "Selection not found" if(current_selection.nil?)
    elsif option == "select channel" || option == "4"
      puts "Enter the name or id"
      current_selection = workspace.select("channel",gets.chomp)
      puts "Selection not found" if(current_selection.nil?)
    elsif option == "details" || option == "5"
      details(current_selection, workspace)
    elsif option == "send message" || option == "6"
      send_message(current_selection, workspace)
    end
    menu
    option = gets.chomp.downcase
  end
  puts "Thank you for using the Ada Slack CLI"
end

def details(recipient, workspace)
  if recipient.nil?
    puts "No recipient selected"
  else
    puts workspace.show_details(recipient)
  end
end

def send_message(recipient, workspace)
  if recipient.nil?
    puts "No recipient selected"
  else
    puts "please enter message"
    workspace.send_message(gets.chomp, recipient)
  end
end

def menu
  puts "Please select one of the three options: "
  puts "1. list users"
  puts "2. list channels"
  puts "3. select user"
  puts "4. select channel"
  puts "5. details"
  puts "6. send message"
  puts "7. quit"
end

main if __FILE__ == $PROGRAM_NAME