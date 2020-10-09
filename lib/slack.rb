#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'table_print'
require_relative 'workspace'

def main
  Dotenv.load

  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  option = nil
  current_selection = nil
  until option == "quit" || option == "8"
    if option == "list users" || option == "1"
      tp workspace.list_users
    elsif option == "list channels" || option == "2"
      tp workspace.list_channels
    elsif option == "select user" || option == "3"
      puts "Enter the name or id"
      current_selection = workspace.select(SlackCLI::User,gets.chomp)
      puts "Selection not found" if(current_selection.nil?)
    elsif option == "select channel" || option == "4"
      puts "Enter the name or id"
      current_selection = workspace.select(SlackCLI::Channel,gets.chomp)
      puts "Selection not found" if(current_selection.nil?)
    elsif option == "details" || option == "5"
      details(current_selection, workspace)
    elsif option == "send message" || option == "6"
      send_message(current_selection, workspace)
    elsif option == "channel history" || option == "7"
      message_history(current_selection, workspace)
    elsif option.nil?
      puts ""
    else
      puts "Please input a valid option"
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
    puts "Please enter message"
    workspace.send_message(gets.chomp, recipient)
  end
end

def message_history(recipient, workspace)
  if recipient.nil? || recipient.is_a?(SlackCLI::User)
    puts "Please select a channel"
  else
    puts workspace.conversation_history(recipient)
  end
end

def menu
  puts "**" * 20
  puts "Please select one of the three options: "
  puts "1. list users"
  puts "2. list channels"
  puts "3. select user"
  puts "4. select channel"
  puts "5. details"
  puts "6. send message"
  puts "7. channel history"
  puts "8. quit"
  puts "**" * 20
end

main if __FILE__ == $PROGRAM_NAME