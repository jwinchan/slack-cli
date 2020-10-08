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
      puts "Are you entering the name or id?"
      name_or_id = gets.chomp
      if(name_or_id == "id")
        puts "Please enter id"
        current_selection = workspace.select(recipient_class: "user", id: gets.chomp)
      else
        puts "Please enter name"
        current_selection = workspace.select(recipient_class: "user", name: gets.chomp)
      end
    elsif option == "select channel" || option == "4"
      puts "Are you entering the name or id?"
      name_or_id = gets.chomp
      if(name_or_id == "id")
        puts "Please enter id"
        current_selection = workspace.select(recipient_class: "channel", id: gets.chomp)
      else
        puts "Please enter name"
        current_selection = workspace.select(recipient_class: "channel", name: gets.chomp)
      end
    elsif option == "details" || option == "5"
      puts workspace.show_details(current_selection)
    elsif option == "send message" || option == "6"
      puts "please enter message"
      message = gets.chomp
      workspace.send_message(message, current_selection)
    end
    menu
    option = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI"
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