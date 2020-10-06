# dotenv_practice.rb
require 'dotenv'
require 'httparty'
# Tell dotenv to look for the .env file
Dotenv.load

puts

channels = HTTParty.get('https://slack.com/api/conversations.list', query: {token: ENV["SLACK_API_TOKEN"]})["channels"].each{|channel| puts channel["name"]}

