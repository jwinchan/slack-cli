# dotenv_practice.rb
require 'dotenv'

# Tell dotenv to look for the .env file
Dotenv.load

p ENV["SLACK_API_TOKEN"]

